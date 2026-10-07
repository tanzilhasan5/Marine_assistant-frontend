import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../routes/app_pages.dart';
import '../utils/app_constants.dart';

class ApiChecker {
  static void checkApi(Response response, {bool getXSnackBar = true}) async {
    // Console response when there is an error
    debugPrint(
      "====> ApiChecker Error: [${response.statusCode}] ${response.request?.url}",
    );
    debugPrint("====> ApiChecker Body: ${response.body}");
    debugPrint("====> ApiChecker StatusText: ${response.statusText}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.body is Map && response.body['message'] != null) {
        showCustomSnackBar(
          response.body['message'].toString(),
          isError: false,
          getXSnackBar: getXSnackBar,
        );
      }
    } else {
      if (response.statusCode == 401) {
        await AppConstants.clearUserData();
        showCustomSnackBar(
            "Session expired. Please log in again.", getXSnackBar: getXSnackBar);

        Get.offAllNamed(Routes.LOGIN);
      } else {
        String? message;
        if (response.body is Map) {
          final bodyMap = response.body as Map;
          if (bodyMap['detail'] != null) {
            message = bodyMap['detail'].toString();
          } else if (bodyMap['message'] != null) {
            message = bodyMap['message'].toString();
          } else if (bodyMap['error'] != null) {
            message = bodyMap['error'].toString();
          }
        }

        // Only show snackbar if an explicit error message came from backend response
        if (message != null && message.isNotEmpty && message != "null") {
          showCustomSnackBar(message, getXSnackBar: getXSnackBar);
        }
      }
    }
  }

  static void showCustomSnackBar(
      String? message, {
        bool isError = true,
        bool getXSnackBar = true,
      }) {
    if (message != null && message.isNotEmpty && message != "null") {
      final bg = isError ? Colors.redAccent : Colors.green;

      if (getXSnackBar) {
        Get.rawSnackbar(
          message: message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: bg,
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          borderRadius: 8,
          duration: const Duration(seconds: 4),
        );
      } else if (Get.context != null) {
        try {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              dismissDirection: DismissDirection.horizontal,
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
                top: MediaQuery.of(Get.context!).padding.top + 10,
                bottom: 10,
              ),
              duration: const Duration(seconds: 4),
              backgroundColor: bg,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              content: Text(
                message,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          );
        } catch (_) {}
      }
    }
  }
}