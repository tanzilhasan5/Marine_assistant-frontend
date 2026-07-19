import 'package:get/get.dart';

import '../controllers/subscription_package_controller.dart';

class SubscriptionPackageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscriptionPackageController>(
      () => SubscriptionPackageController(),
    );
  }
}
