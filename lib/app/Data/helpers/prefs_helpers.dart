
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_constants.dart';

class PrefsHelper extends GetxService {
  static PrefsHelper get to => Get.find();
  static late SharedPreferences _prefsInstance;

  // ======================= Initialize (Call this in main.dart) =======================
  static Future<PrefsHelper> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
    return PrefsHelper(); // Return instance for GetX
  }

  // ========================== SET DATA =================================
  static Future<bool> setString(String key, String value) async {
    return await _prefsInstance.setString(key, value);
  }

  static Future<bool> setBool(String key, bool value) async {
    return await _prefsInstance.setBool(key, value);
  }

  static Future<bool> setInt(String key, int value) async {
    return await _prefsInstance.setInt(key, value);
  }

  // ========================== GET DATA =================================
  static String getString(String key, [String defaultValue = ""]) {
    return _prefsInstance.getString(key) ?? defaultValue;
  }

  static bool getBool(String key, [bool defaultValue = false]) {
    return _prefsInstance.getBool(key) ?? defaultValue;
  }

  static int getInt(String key, [int defaultValue = -1]) {
    return _prefsInstance.getInt(key) ?? defaultValue;
  }

  // ========================== REMOVE & CLEAR =================================
  static Future<bool> remove(String key) async {
    return await _prefsInstance.remove(key);
  }

  static Future<bool> clearAll() async {
    return await _prefsInstance.clear();
  }

  // ========================== CHECK LOGIN STATUS =================================
  static bool get isLoggedIn {
    final token = getString(AppConstants.bearerToken);
    if (token.isEmpty) return false;
    return !isTokenExpired(token);
  }

  // ========================== CHECK JWT EXPIRATION =================================
  static bool isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length < 3) return false; // Not a JWT, assume valid locally

      // Normalize base64 string
      String payloadStr = parts[1];
      int remaining = payloadStr.length % 4;
      if (remaining > 0) {
        payloadStr += '=' * (4 - remaining);
      }

      final payloadJson = utf8.decode(base64Url.decode(payloadStr));
      final payload = jsonDecode(payloadJson);
      if (payload is Map && payload.containsKey('exp')) {
        final exp = payload['exp'];
        if (exp is int) {
          final expiryTime = DateTime.fromMillisecondsSinceEpoch(exp * 1000, isUtc: true);
          return DateTime.now().toUtc().isAfter(expiryTime);
        }
      }
      return false; // If no exp field is found, assume not expired
    } catch (e) {
      return false; // Assume valid on decode error (safer fallback)
    }
  }
}