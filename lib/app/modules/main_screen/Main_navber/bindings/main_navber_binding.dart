import 'package:get/get.dart';

import '../controllers/main_navber_controller.dart';

class MainNavberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainNavberController>(
      () => MainNavberController(),
    );
  }
}
