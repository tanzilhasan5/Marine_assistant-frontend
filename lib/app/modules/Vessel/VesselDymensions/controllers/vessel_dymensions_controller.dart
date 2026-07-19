import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';

class VesselDymensionsController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController lengthController;
  late TextEditingController beamController;
  late TextEditingController draftController;
  late TextEditingController airDraftController;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController(text: '');
    lengthController = TextEditingController(text: '');
    beamController = TextEditingController(text: '');
    draftController = TextEditingController(text: '');
    airDraftController = TextEditingController(text: '');
  }

  @override
  void onClose() {
    nameController.dispose();
    lengthController.dispose();
    beamController.dispose();
    draftController.dispose();
    airDraftController.dispose();
    super.onClose();
  }

  void saveVessel() {
    final name = nameController.text.trim();
    final length = lengthController.text.trim();
    final beam = beamController.text.trim();
    final draft = draftController.text.trim();
    final airDraft = airDraftController.text.trim();

    if (name.isEmpty || length.isEmpty || beam.isEmpty || draft.isEmpty || airDraft.isEmpty) {
      Get.snackbar(
        backgroundColor: Colors.red,
        colorText: Colors.white,
        'Validation Error',
        'Please enter all vessel dimensions',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    Get.offAllNamed(Routes.MAIN_NAVBER);
  }
}
