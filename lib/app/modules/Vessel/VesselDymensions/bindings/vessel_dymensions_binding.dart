import 'package:get/get.dart';

import '../controllers/vessel_dymensions_controller.dart';

class VesselDymensionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VesselDymensionsController>(
      () => VesselDymensionsController(),
    );
  }
}
