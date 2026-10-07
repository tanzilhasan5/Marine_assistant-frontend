/*
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Data/services/api_checker.dart';
import '../../../../Data/services/api_client.dart';
import '../../../../Data/services/api_constant.dart';
import '../../../../routes/app_pages.dart';

class SignUpOtpController extends GetxController {
  final TextEditingController pinController = TextEditingController();
  final RxBool isLoading = false.obs;
  Timer? _timer;
  final secondsRemaining = 0.obs;
  final isTimerActive = false.obs;

  @override
  void onClose() {
    pinController.dispose();
    _timer?.cancel();
    super.onClose();
  }

  void startTimer() {
    secondsRemaining.value = 30;
    isTimerActive.value = true;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 1) {
        secondsRemaining.value--;
      } else {
        secondsRemaining.value = 0;
        isTimerActive.value = false;
        _timer?.cancel();
      }
    });
  }
   Future<void>otpverifry(String email, String otpCode) async {
    isLoading(true);
    try {
      var headers = {'Content-Type': 'application/json'};
      var response = await ApiClient.postData(
        ApiConstant.verifyOtp,
        jsonEncode({"email": email, "otp_code": otpCode}),
        headers: headers,
      );
      if (response.statusCode == 200 ) {
        Get.toNamed(Routes.VERIFED, arguments: {'nextRoute': Routes.LOGIN});
      } else {
        final body = response.body is Map
            ? response.body
            : (response.body is String ? jsonDecode(response.body) : {});
        String msg = body['message'] ?? 'OTP verification failed';
        if (body['errors'] != null && body['errors']['otp'] != null) {
          msg = (body['errors']['otp'] as List).join(', ');
        }
        Get.snackbar(
          'Error',
          msg,
          snackPosition: SnackPosition.TOP,
        );
        debugPrint(response.bodyString);
      }
    } catch (e) {
      debugPrint('OTP Error: $e');
      Get.snackbar(
        'Error',
        'Failed to verify OTP',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading(false);
    }
  }
   Future<void>resend(String email,) async {
    isLoading(true);
    try {
      var headers = {'Content-Type': 'application/json'};
      var response = await ApiClient.postData(
        ApiConstant.login,
        jsonEncode({"email": email,}),
        headers: headers,
      );
      if (response.statusCode == 200 ) {
        Get.snackbar(
          'Success',
          'OTP verified successfully',
          snackPosition: SnackPosition.TOP,
        );
      } else {
        final body = response.body is Map
            ? response.body
            : (response.body is String ? jsonDecode(response.body) : {});
        String msg = body['message'] ?? 'OTP verification failed';
        if (body['errors'] != null && body['errors']['otp'] != null) {
          msg = (body['errors']['otp'] as List).join(', ');
        }
        Get.snackbar(
          'Error',
          msg,
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

*/
/*  void verifyOtp() {
    final code = pinController.text.trim();
    if (code.length < 6) {
      Get.snackbar(
        'Validation Error',
        'Please enter the full 6-digit OTP code',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    Get.toNamed(Routes.VERIFED, arguments: {'nextRoute': Routes.LOGIN});
  }*/ /*


}
*/

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../Data/services/api_client.dart';
import '../../../../Data/services/api_constant.dart';
import '../../../../routes/app_pages.dart';

class SignUpOtpController extends GetxController {
  final TextEditingController pinController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isResendLoading = false.obs;

  Timer? _timer;

  final secondsRemaining = 0.obs;
  final isTimerActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void startTimer() {
    _timer?.cancel();

    secondsRemaining.value = 30;
    isTimerActive.value = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 1) {
        secondsRemaining.value--;
      } else {
        secondsRemaining.value = 0;
        isTimerActive.value = false;
        timer.cancel();
      }
    });
  }

  Future<void> otpverifry(String email, String otpCode) async {
    final code = otpCode.trim();

    if (code.length != 6) {
      Get.rawSnackbar(
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(20),
        message: 'Please enter the full 6-digit OTP code',
      );
      return;
    }

    if (isLoading.value) return;

    isLoading(true);

    try {
      final headers = {'Content-Type': 'application/json'};

      final response = await ApiClient.postData(
        ApiConstant.verifyOtp,
        jsonEncode({"email": email, "otp_code": code}),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Get.offAllNamed(Routes.VERIFED, arguments: {'nextRoute': Routes.LOGIN});
      } else {
        final body = response.body is Map
            ? response.body
            : (response.body is String ? jsonDecode(response.body) : {});

        String msg = body['message'] ?? 'OTP verification failed';

        if (body['errors'] != null && body['errors']['otp'] != null) {
          msg = (body['errors']['otp'] as List).join(', ');
        }

        Get.snackbar('Error', msg, snackPosition: SnackPosition.TOP);

        debugPrint(response.bodyString);
      }
    } catch (e) {
      debugPrint('OTP Error: $e');

      Get.snackbar(
        'Error',
        'Failed to verify OTP',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> resend(String email) async {
    if (isTimerActive.value || isResendLoading.value) return;

    isResendLoading(true);

    try {
      final headers = {'Content-Type': 'application/json'};

      final response = await ApiClient.postData(
        ApiConstant.login,
        jsonEncode({"email": email}),
        headers: headers,
      );

      if (response.statusCode == 200) {
        startTimer();

        Get.rawSnackbar(
          duration: Duration(seconds: 1),
          margin: EdgeInsets.symmetric(horizontal: 5),
          borderRadius: 10.r,

          message: 'OTP sent successfully',
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP,
        );
      } else {
        final body = response.body is Map
            ? response.body
            : (response.body is String ? jsonDecode(response.body) : {});

        String msg = body['message'] ?? 'Failed to resend OTP';

        if (body['errors'] != null && body['errors']['otp'] != null) {
          msg = (body['errors']['otp'] as List).join(', ');
        }

        Get.snackbar('Error', msg, snackPosition: SnackPosition.TOP);

        debugPrint(response.bodyString);
      }
    } catch (e) {
      debugPrint('Resend OTP Error: $e');

      Get.snackbar(
        'Error',
        'Failed to resend OTP',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 1),
      );
    } finally {
      isResendLoading(false);
    }
  }
}
