import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';

class LoginOptionController extends GetxController {
  void loginWithApple() {
    Get.snackbar(
      'Sign In',
      'Apple Sign-In is mocked!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void loginWithGoogle() {
    Get.snackbar(
      'Sign In',
      'Google Sign-In is mocked!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void loginWithEmail() {
    Get.toNamed(Routes.LOGIN);
  }
}
