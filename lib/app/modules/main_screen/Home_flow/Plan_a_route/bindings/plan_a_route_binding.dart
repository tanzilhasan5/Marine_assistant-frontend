import 'package:get/get.dart';

import '../controllers/plan_a_route_controller.dart';

class PlanARouteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlanARouteController>(
      () => PlanARouteController(),
    );
  }
}
