import 'package:get/get.dart';
import 'package:marine_assistant/app/modules/main_screen/Cummunity_flow/Cummunity/controllers/cummunity_controller.dart';
import 'package:marine_assistant/app/modules/main_screen/Fule_calculator/Fluel_planer/controllers/fluel_planer_controller.dart';
import 'package:marine_assistant/app/modules/main_screen/Report_flow/Report/controllers/report_controller.dart';

import '../controllers/main_navber_controller.dart';

class MainNavberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainNavberController>(
      () => MainNavberController(),
    );
    Get.lazyPut<FluelPlanerController>(
      () => FluelPlanerController(),
    );
    Get.lazyPut<ReportController>(
      () => ReportController(),
    );
    Get.lazyPut<CummunityController>(
      () => CummunityController(),
    );
  }
}
