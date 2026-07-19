import 'package:get/get.dart';

import '../controllers/login_option_controller.dart';

class LoginOptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginOptionController>(
      () => LoginOptionController(),
    );
  }
}
