import 'package:get/get.dart';

import '../controllers/fluel_planer_controller.dart';

class FluelPlanerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FluelPlanerController>(
      () => FluelPlanerController(),
    );
  }
}
