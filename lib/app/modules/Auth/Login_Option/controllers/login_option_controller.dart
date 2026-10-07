import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';

class LoginOptionController extends GetxController {
  void loginWithApple() {
    Get.rawSnackbar(
      message: ' Apple Sign-In is mocked!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.black87,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      duration: const Duration(seconds: 4),
    );  }

  void loginWithGoogle() {
    Get.rawSnackbar(
      message: ' Google Sign-In is mocked!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.black87,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      duration: const Duration(seconds: 4),
    );  }

  void loginWithEmail() {
    Get.toNamed(Routes.LOGIN);
  }
}
