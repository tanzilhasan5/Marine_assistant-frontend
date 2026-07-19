import 'package:get/get.dart';

import '../controllers/engineand_fuel_controller.dart';

class EngineandFuelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EngineandFuelController>(
      () => EngineandFuelController(),
    );
  }
}
