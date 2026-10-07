import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Data/services/api_checker.dart';
import '../../../../Data/services/api_client.dart';
import '../../../../Data/services/api_constant.dart';
import '../../../../routes/app_pages.dart';

class SignUpController extends GetxController {


  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final RxBool isLoading = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    super.onClose();
  }

  Future<void> register() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();

    if (name.isEmpty) {
      Get.rawSnackbar(
        messageText: const Text(
          'Validation Error ! Please enter your name.',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
        borderRadius: 8,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(12),
      );
      return;
    }

    if (email.isEmpty) {
      Get.rawSnackbar(
        messageText: const Text(
          'Validation Error ! Please enter your email.',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
        borderRadius: 8,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(12),
      );
      return;
    }

    isLoading.value = true;
    var headers = {'Content-Type': 'application/json'};
    var response = await ApiClient.postData(
      ApiConstant.signup,
      jsonEncode(
        {
          "email": email,
          "full_name": name,
        },
      ),
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.toNamed(Routes.SIGN_UP_OTP, arguments: email);
    } else {
      ApiChecker.checkApi(response);

      debugPrint('Error: ${response.statusText}');
      debugPrint('Error: ${response.bodyString}');
    }
    isLoading.value = false;
  }
}
