import 'package:get/get.dart';

import '../controllers/verifed_controller.dart';

class VerifedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifedController>(
      () => VerifedController(),
    );
  }
}
