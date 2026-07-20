import 'package:get/get.dart';

class SubscriptionPackageController extends GetxController {
  final selectedPlan = 'Weekly'.obs;

  void selectPlan(String plan) {
    selectedPlan.value = plan;
  }

  void onUnlockAccess() {
    Get.back();
  }
}
