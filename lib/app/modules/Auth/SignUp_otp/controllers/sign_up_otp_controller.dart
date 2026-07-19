import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';

class SignUpOtpController extends GetxController {
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
        'Validation Error',
        'Please enter the full 6-digit OTP code',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    Get.toNamed(Routes.VERIFED, arguments: {'nextRoute': Routes.LOGIN});
  }

  void resendOtp() {
    if (isTimerActive.value) return;

    startTimer();
    Get.snackbar(
      'OTP Resent',
      'A new verification code has been sent to your email.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
