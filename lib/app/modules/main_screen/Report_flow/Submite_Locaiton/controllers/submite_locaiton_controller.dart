import 'package:get/get.dart';
import '../../../../../routes/app_pages.dart';

class SubmiteLocaitonController extends GetxController {
  final locationName = 'Egmont Key Marina'.obs;
  final severity = 'High'.obs;

  void onCloseReport() {
    Get.offAllNamed(Routes.MAIN_NAVBER);
  }
}
