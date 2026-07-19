import 'package:get/get.dart';

import '../controllers/cummunity_controller.dart';

class CummunityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CummunityController>(
      () => CummunityController(),
    );
  }
}
