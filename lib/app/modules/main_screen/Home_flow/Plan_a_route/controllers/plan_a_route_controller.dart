import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_pages.dart';

class PlanARouteController extends GetxController {
  final searchController = TextEditingController();
  final selectedDestination = ''.obs;

  final recentDestinations = <Map<String, String>>[
    {'name': 'Egmont Key Marina', 'distance': '12.4nm'},
    {'name': 'Sunset Cove Fuel Dock', 'distance': '6.1nm'},
    {'name': 'Anclote Key Anchorage', 'distance': '19.8nm'},
  ].obs;

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void selectDestination(String name) {
    selectedDestination.value = name;
    searchController.text = name;
  }

  void onDropPinOnMap() {
    selectedDestination.value = 'Pinned Location';
    searchController.text = 'Pinned Location';
  }

  void onContinue() {
    Get.toNamed(Routes.SUGGESTED_ROUTE);
  }
}
