import 'package:get/get.dart';

import '../controllers/vessel_setup_controller.dart';

class VesselSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VesselSetupController>(
      () => VesselSetupController(),
    );
  }
}
