import 'package:get/get.dart';

class ChangeLanguageController extends GetxController {
  final selectedLanguage = 'English'.obs;

  final languages = <String>[
    'English',
    'Hindi',
    'Spanish',
  ];

  void selectLanguage(String lang) {
    selectedLanguage.value = lang;
  }
}
