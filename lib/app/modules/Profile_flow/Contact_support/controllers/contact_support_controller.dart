import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactSupportController extends GetxController {
  final messageController = TextEditingController();
  final attachedFileName = ''.obs;

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  void onUploadFile() {
    attachedFileName.value = 'screenshot_log.png';
  }

  void onSubmitNow() {
    Get.back();
  }
}
