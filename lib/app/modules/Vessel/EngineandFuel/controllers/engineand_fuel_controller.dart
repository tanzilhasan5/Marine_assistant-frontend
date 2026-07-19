import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';

class EngineandFuelController extends GetxController {
  final selectedEngineType = 'Diesel'.obs;

  late TextEditingController motorController;
  late TextEditingController tankCapacityController;
  late TextEditingController currentLitersController;
  late TextEditingController reserveMarginController;
  late TextEditingController consumptionController;
  late TextEditingController cruiseSpeedController;

  @override
  void onInit() {
    super.onInit();
    motorController = TextEditingController(text: '2');
    tankCapacityController = TextEditingController(text: '200');
    currentLitersController = TextEditingController(text: '200');
    reserveMarginController = TextEditingController(text: '15');
    consumptionController = TextEditingController(text: '8');
    cruiseSpeedController = TextEditingController(text: '7');
  }

  @override
  void onClose() {
    motorController.dispose();
    tankCapacityController.dispose();
    currentLitersController.dispose();
    reserveMarginController.dispose();
    consumptionController.dispose();
    cruiseSpeedController.dispose();
    super.onClose();
  }

  void selectEngineType(String type) {
    selectedEngineType.value = type;
  }

  void continueToNavbar() {
    final motor = motorController.text.trim();
    final capacity = tankCapacityController.text.trim();
    final current = currentLitersController.text.trim();
    final reserve = reserveMarginController.text.trim();
    final consumption = consumptionController.text.trim();
    final cruise = cruiseSpeedController.text.trim();

    if (motor.isEmpty || capacity.isEmpty || current.isEmpty || reserve.isEmpty || consumption.isEmpty || cruise.isEmpty) {
      Get.snackbar(
        backgroundColor: Colors.red,
        colorText: Colors.white,

        'Validation Error',
        'Please enter all engine & fuel details',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    Get.offAllNamed(Routes.VESSEL_DYMENSIONS);
  }
}
