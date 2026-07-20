import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../utils/images.dart';
import '../../Home/controllers/home_controller.dart';

class SuggestedRouteController extends GetxController {
  final isNavigating = false.obs;
  final isAlertsVisible = true.obs;

  final destinationName = 'Egmont Key Marina'.obs;
  final distance = '12.4 nm'.obs;
  final eta = '48 min'.obs;
  final aveSpeed = '15.6 kt'.obs;

  final alerts = <Map<String, dynamic>>[
    {
      'icon': Images.alertsRed,
      'text': 'Shoal reported ahead',
      'color': const Color(0xFFFF5252),
    },
    {
      'icon': Images.alertYellow,
      'text': 'Heavy traffic near channel',
      'color': const Color(0xFFFFB74D),
    },
    {
      'icon': Images.alertBlue,
      'text': 'Shoal reported ahead',
      'color': const Color(0xFF29B6F6),
    },
  ].obs;

  void toggleAlertsVisibility() {
    isAlertsVisible.value = !isAlertsVisible.value;
  }

  void onStartNavigate() {
    isNavigating.value = true;
  }

  void onEndNavigation() {
    isNavigating.value = false;

    // Set home controller active route to true
    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().hasActiveRoute.value = true;
    }
    Get.offAllNamed(Routes.MAIN_NAVBER);
  }

  void onEditRoute() {
    Get.back();
  }
}
