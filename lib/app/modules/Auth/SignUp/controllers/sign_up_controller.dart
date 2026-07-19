import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';

class SignUpController extends GetxController {
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

  void signUp() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter both name and email',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Get.toNamed(Routes.SIGN_UP_OTP);
  }
}
