import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_pages.dart';

class FluelPlanerController extends GetxController {
  final startLocationController = TextEditingController();
  final endLocationController = TextEditingController();
  final boatTypeController = TextEditingController();
  final lengthController = TextEditingController();
  final engineConfigController = TextEditingController();
  final avgConsumptionController = TextEditingController();
  final availableFuelController = TextEditingController();
  final minReserveController = TextEditingController();
  final routeDistanceController = TextEditingController();

  @override
  void onClose() {
    startLocationController.dispose();
    endLocationController.dispose();
    boatTypeController.dispose();
    lengthController.dispose();
    engineConfigController.dispose();
    avgConsumptionController.dispose();
    availableFuelController.dispose();
    minReserveController.dispose();
    routeDistanceController.dispose();
    super.onClose();
  }

  void onCalculateRange() {
    Get.toNamed(Routes.FLUEL_PLANER_RESULT);
  }
}
