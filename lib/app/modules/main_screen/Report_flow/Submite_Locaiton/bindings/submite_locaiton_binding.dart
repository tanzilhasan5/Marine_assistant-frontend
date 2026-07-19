import 'package:get/get.dart';

import '../controllers/submite_locaiton_controller.dart';

class SubmiteLocaitonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubmiteLocaitonController>(
      () => SubmiteLocaitonController(),
    );
  }
}
