import 'package:get/get.dart';

import '../controllers/suggested_route_controller.dart';

class SuggestedRouteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuggestedRouteController>(
      () => SuggestedRouteController(),
    );
  }
}
