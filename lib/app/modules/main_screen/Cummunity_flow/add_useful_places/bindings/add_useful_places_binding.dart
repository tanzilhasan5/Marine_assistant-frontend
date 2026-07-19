import 'package:get/get.dart';

import '../controllers/add_useful_places_controller.dart';

class AddUsefulPlacesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddUsefulPlacesController>(
      () => AddUsefulPlacesController(),
    );
  }
}
