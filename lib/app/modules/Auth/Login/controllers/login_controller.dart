import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';

class LoginController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController emailController;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    super.onClose();
  }

  void login() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();

    if ( email.isEmpty) {
      Get.snackbar(
        colorText: Colors.white,
        backgroundColor: Colors.red,

        'Validation Error',
        'Please enter your email',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    Get.toNamed(Routes.LOGIN_OTP);
  }
}
