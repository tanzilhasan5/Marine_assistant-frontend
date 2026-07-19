import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';

class VesselSetupController extends GetxController {
  final selectedType = 'Sailboat'.obs;

  void selectVesselType(String type) {
    selectedType.value = type;
  }

  void goToNextStep() {
    Get.toNamed(Routes.ENGINEAND_FUEL);
  }

  void skipSetup() {
    Get.offAllNamed(Routes.MAIN_NAVBER);
  }
}
