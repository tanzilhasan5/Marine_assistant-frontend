import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../helpers/prefs_helpers.dart';
import '../utils/app_constants.dart';
import 'api_checker.dart';
import 'api_client.dart';
import 'api_constant.dart';
import '../../routes/app_pages.dart';

class AppleAuthService {
  /// Generates a cryptographically secure random nonce.
  static String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
          (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  /// Returns the SHA-256 hash of the input string, used by Apple's nonce flow.
  static String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Handles Apple Authentication & Signup flow.
  static Future<bool> appleLogin() async {
    try {
      // Generate raw nonce and its SHA-256 hash.
      // Apple gets the hashed nonce; Firebase gets the raw nonce.
      final rawNonce = _generateNonce();
      final hashedNonce = _sha256ofString(rawNonce);

      final AuthorizationCredentialAppleID credential =
      await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: hashedNonce,
      );

      final String? identityToken = credential.identityToken;
      if (identityToken == null) {
        throw Exception("Apple login failed: Identity token is null");
      }

      debugPrint('Apple Identity Token: $identityToken');

      try {
        final parts = identityToken.split('.');
        if (parts.length > 1) {
          final payload = utf8.decode(
            base64Url.decode(base64Url.normalize(parts[1])),
          );
          debugPrint('Decoded Apple Token Payload: $payload');
        }
      } catch (e) {
        debugPrint('Failed to decode Apple token for debugging: $e');
      }

      // Authenticate to Firebase with Apple Credential to get Firebase ID Token
      final OAuthProvider oAuthProvider = OAuthProvider('apple.com');
      final AuthCredential authCredential = oAuthProvider.credential(
        idToken: identityToken,
        rawNonce: rawNonce,
        accessToken: credential.authorizationCode,
      );
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(authCredential);
      final String? firebaseIdToken = await userCredential.user?.getIdToken();

      debugPrint('Firebase ID Token for Apple: $firebaseIdToken');

      // Decode and print the Firebase token payload to verify the project ID (aud)
      try {
        final parts = firebaseIdToken!.split('.');
        if (parts.length > 1) {
          final payload = utf8.decode(
            base64Url.decode(base64Url.normalize(parts[1])),
          );
          debugPrint('Decoded Firebase ID Token Payload: $payload');
        }
      } catch (e) {
        debugPrint('Failed to decode Firebase ID Token for debugging: $e');
      }

      Map<String, dynamic> body = {
        "id_token": firebaseIdToken,
      };


      Response response = await ApiClient.postData(
        ApiConstant.firebaseAuth,
        jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Social auth backend response: ${response.body}');
        final responseData = response.body;
        if (responseData != null) {
          String? token;
          if (responseData is Map) {
            if (responseData['data'] is Map) {
              token = responseData['data']['access'] ??
                  responseData['data']['token'] ??
                  responseData['data']['accessToken'] ??
                  responseData['data']['access_token'];
            }
            token ??= responseData['access'] ??
                responseData['token'] ??
                responseData['accessToken'] ??
                responseData['access_token'];
          }

          if (token != null && token.toString().isNotEmpty) {
            await PrefsHelper.setString(
              AppConstants.bearerToken,
              token.toString(),
            );
            await PrefsHelper.setBool(AppConstants.isLoggedIn, true);
          }

          final user = responseData['user'] ?? responseData['data']?['user'];
          String userId = '';
          if (user != null && user is Map) {
            final parsedId = user['id']?.toString() ?? '';
            if (parsedId.isNotEmpty) {
              userId = parsedId;
              await PrefsHelper.setString(AppConstants.userId, userId);
            }
            if (user['full_name'] != null) {
              await PrefsHelper.setString(AppConstants.userName, user['full_name'].toString());
            } else if (user['first_name'] != null) {
              String fullName = user['first_name'].toString();
              if (user['last_name'] != null) {
                fullName += ' ${user['last_name']}';
              }
              await PrefsHelper.setString(AppConstants.userName, fullName.trim());
            }
            if (user['email'] != null) {
              await PrefsHelper.setString(AppConstants.userEmail, user['email'].toString());
            }
          } else if (responseData is Map) {
            final parsedId =
                responseData['id']?.toString() ??
                    responseData['data']?['id']?.toString() ??
                    '';
            if (parsedId.isNotEmpty) {
              userId = parsedId;
              await PrefsHelper.setString(AppConstants.userId, userId);
            }
          }

          // Trigger RevenueCat if initialized
          if (userId.isNotEmpty) {
            try {
              await Purchases.logIn(userId);
            } catch (e) {
              debugPrint("Failed to logIn to RevenueCat during Apple auth: $e");
            }
          }



          if (credential.givenName != null &&
              credential.givenName!.isNotEmpty) {
            String fullName = credential.givenName!;
            if (credential.familyName != null &&
                credential.familyName!.isNotEmpty) {
              fullName += ' ${credential.familyName}';
            }
            await PrefsHelper.setString(AppConstants.userName, fullName.trim());
          }

          String msg = 'Apple authentication successful!';
          if (responseData is Map && responseData.containsKey('message')) {
            msg = responseData['message'].toString();
          } else if (responseData is Map && responseData['data'] is Map && responseData['data'].containsKey('message')) {
            msg = responseData['data']['message'].toString();
          }
          ApiChecker.showCustomSnackBar(msg, isError: false);

          Get.offAllNamed(Routes.MAIN_NAVBER);
          return true;
        }
      } else {
        ApiChecker.checkApi(response);
      }
      return false;
    } catch (error) {
      debugPrint("Apple Sign-In Error: $error");

      // Do not display an error message if the user manually cancelled the request.
      // Error code 1001 signifies ASAuthorizationErrorCanceled.
      if (error.toString().contains('SignInWithAppleAuthorizationError') &&
          error.toString().contains('1001')) {
        return false;
      }

      Get.rawSnackbar(
        messageText: Text(
          'Apple sign-in failed: $error',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 4),
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );      return false;
    }
  }
}
