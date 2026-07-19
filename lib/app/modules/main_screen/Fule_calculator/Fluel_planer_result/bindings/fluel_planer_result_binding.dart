import 'package:get/get.dart';

import '../controllers/fluel_planer_result_controller.dart';

class FluelPlanerResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FluelPlanerResultController>(
      () => FluelPlanerResultController(),
    );
  }
}
