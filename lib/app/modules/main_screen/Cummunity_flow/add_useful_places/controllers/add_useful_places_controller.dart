import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_pages.dart';

class AddUsefulPlacesController extends GetxController {
  final placeNameController = TextEditingController();
  final categoryController = TextEditingController(text: 'Fuel Stations');
  final statusController = TextEditingController(text: 'Open');

  @override
  void onClose() {
    placeNameController.dispose();
    categoryController.dispose();
    statusController.dispose();
    super.onClose();
  }

  void onSubmitPlaces() {
    Get.offAllNamed(Routes.MAIN_NAVBER);
  }
}
