import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ContactSupportController extends GetxController {
  final messageController = TextEditingController();
  final attachedFileName = ''.obs;

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  Future<void> onUploadFile() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        attachedFileName.value = file.name;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not pick file',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF132A3E),
        colorText: Colors.white,
      );
    }
  }

  void onSubmitNow() {
    Get.back();
  }
}
