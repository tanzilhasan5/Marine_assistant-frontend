import 'package:get/get.dart';
import '../../../../../routes/app_pages.dart';

class CummunityController extends GetxController {
  final selectedTab = 'Useful Places'.obs;

  final activeNearby = 12.obs;
  final hazardsToday = 4.obs;
  final confirmations = 37.obs;

  final tabs = <String>[
    'Nearby',
    'Hazards',
    'Useful Places',
    'My Reports',
  ];

  void selectTab(String tab) {
    selectedTab.value = tab;
  }

  void onAddReport() {
    Get.toNamed(Routes.REPORT);
  }

  void onAddUsefulPlaces() {
    Get.toNamed(Routes.ADD_USEFUL_PLACES);
  }

  void onNavigate() {
    Get.toNamed(Routes.SUGGESTED_ROUTE);
  }
}
