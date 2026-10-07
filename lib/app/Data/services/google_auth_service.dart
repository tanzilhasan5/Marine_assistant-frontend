import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../helpers/prefs_helpers.dart';
import '../utils/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'api_checker.dart';
import 'api_client.dart';
import 'api_constant.dart';
import '../../routes/app_pages.dart';

class GoogleAuthService {
  /// Handles Google Authentication & Signup flow.
  /// On Android, [serverClientId] (Web Client ID from Google/Firebase console) is required to obtain idToken.
  static Future<bool> googleLogin({
    String? serverClientId,
  }) async {
    try {
      final String? clientId = (serverClientId != null && serverClientId.isNotEmpty)
          ? serverClientId
          : (AppConstants.googleServerClientId.isNotEmpty &&
                  AppConstants.googleServerClientId != 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com')
              ? AppConstants.googleServerClientId
              : null;

      final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId: clientId,
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        debugPrint('Google Sign-In cancelled by user.');
        return false;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      debugPrint('Google ID Token: ${googleAuth.idToken}');

      // Authenticate to Firebase with Google Credential to get Firebase ID Token
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final String? firebaseIdToken = await userCredential.user?.getIdToken();

      debugPrint('Firebase ID Token: $firebaseIdToken');

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
        headers: {
          'Content-Type': 'application/json',
        },
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
            await PrefsHelper.setString(AppConstants.bearerToken, token.toString());
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
            final parsedId = responseData['id']?.toString() ?? responseData['data']?['id']?.toString() ?? '';
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
              debugPrint("Failed to logIn to RevenueCat during Google auth: $e");
            }
          }



          if (googleUser.displayName != null && googleUser.displayName!.isNotEmpty ) {
            await PrefsHelper.setString(AppConstants.userName, googleUser.displayName!);
          }

          String msg = 'Google authentication successful!';
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
        debugPrint(response.bodyString);
      }
      return false;
    } catch (error) {
      debugPrint("Google Sign-In Error: $error");
      String errorMsg = 'Google sign-in failed: $error';
      if (error.toString().contains('serverClientId must be provided')) {
        errorMsg = 'Google Sign-In configuration error: Please set your Web Client ID in AppConstants.googleServerClientId';
      }
      Get.rawSnackbar(
        message: errorMsg,
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 4),
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
      return false;
    }
  }
}
