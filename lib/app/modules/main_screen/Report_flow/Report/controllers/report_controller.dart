import 'package:get/get.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../utils/images.dart';

class ReportController extends GetxController {
  final selectedHazard = 'Shoal'.obs;

  final hazards = <Map<String, String>>[
    {'name': 'Shoal', 'icon': Images.shoal},
    {'name': 'Rock / Obstacle', 'icon': Images.rockObstacle},
    {'name': 'Wreck', 'icon': Images.wreck},
    {'name': 'Fishing Net', 'icon': Images.fishingNet},
    {'name': 'Heavy Traffic', 'icon': Images.heavyTraffic},
    {'name': 'Rough Sea', 'icon': Images.wave},
    {'name': 'Shallow Area', 'icon': Images.shallowArea},
    {'name': 'Unlit Buoy', 'icon': Images.unlitBuoy},
    {'name': 'Coastguard Boat', 'icon': Images.coastguardBoat},
  ].obs;

  void selectHazard(String name) {
    selectedHazard.value = name;
  }

  void onContinue() {
    Get.toNamed(Routes.CONFIRM_LOCAITON);
  }
}
