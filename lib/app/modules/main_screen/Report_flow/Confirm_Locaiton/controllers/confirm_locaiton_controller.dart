import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_pages.dart';
import '../../Submite_Locaiton/controllers/submite_locaiton_controller.dart';

class ConfirmLocaitonController extends GetxController {
  final noteController = TextEditingController();
  final selectedSeverity = 'Low'.obs;

  final severities = <Map<String, dynamic>>[
    {
      'label': 'Low',
      'activeColor': const Color(0xFF1B85FF),
      'activeBg': Colors.white,
    },
    {
      'label': 'Medium',
      'activeColor': const Color(0xFFFFB74D),
      'activeBg': Colors.white,
    },
    {
      'label': 'High',
      'activeColor': const Color(0xFFFF5252),
      'activeBg': Colors.white,
    },
  ];

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }

  void selectSeverity(String label) {
    selectedSeverity.value = label;
  }

  void onSubmitReport() {
    if (Get.isRegistered<SubmiteLocaitonController>()) {
      Get.find<SubmiteLocaitonController>().severity.value =
          selectedSeverity.value;
    }
    Get.toNamed(Routes.SUBMITE_LOCAITON);
  }
}
