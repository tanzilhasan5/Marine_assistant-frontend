import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';

class LoginOtpController extends GetxController {
  late TextEditingController pinController;
  Timer? _timer;
  final secondsRemaining = 0.obs;
  final isTimerActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    pinController = TextEditingController();
  }

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

  void verifyOtp() {
    final code = pinController.text.trim();
    if (code.length < 6) {
      Get.snackbar(
        backgroundColor: Colors.red,
        colorText: Colors.white,

        'Validation Error',
        'Please enter the full 6-digit OTP code',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }
    Get.toNamed(Routes.MAIN_NAVBER);
  }

  void resendOtp() {
    if (isTimerActive.value) return;

    startTimer();
    Get.snackbar(
      backgroundColor: Colors.green,
      'OTP Resent',
      'A new verification code has been sent to your email.',
      snackPosition: SnackPosition.TOP,
    );
  }
}
