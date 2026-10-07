import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Data/services/api_client.dart';
import '../../../../Data/services/api_constant.dart';
import '../../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final TextEditingController emailController= TextEditingController();
  RxBool isLoading =false.obs;




  Future<void>login(String email,) async {
    isLoading(true);
    try {
      var headers = {'Content-Type': 'application/json'};
      var response = await ApiClient.postData(
        ApiConstant.login,
        jsonEncode({"email": email,}),
        headers: headers,
      );
      if (response.statusCode == 200 ) {

        Get.toNamed(Routes.LOGIN_OTP,arguments: email);



      } else {
        final body = response.body is Map
            ? response.body
            : (response.body is String ? jsonDecode(response.body) : {});
        String msg = body['message'] ?? 'OTP verification failed';
        if (body['errors'] != null && body['errors']['otp'] != null) {
          msg = (body['errors']['otp'] as List).join(', ');
        }
        Get.rawSnackbar(
          message: msg,
          snackPosition: SnackPosition.TOP,
        );
        debugPrint(response.bodyString);
      }
    } catch (e) {
      debugPrint('OTP Error: $e');
      Get.snackbar(
        duration: Duration(seconds: 1),
        'Error',
        'Failed to verify OTP',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading(false);
    }
  }





}
