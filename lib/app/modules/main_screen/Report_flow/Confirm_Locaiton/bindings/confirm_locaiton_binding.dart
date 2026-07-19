import 'package:get/get.dart';

import '../controllers/confirm_locaiton_controller.dart';

class ConfirmLocaitonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmLocaitonController>(
      () => ConfirmLocaitonController(),
    );
  }
}
