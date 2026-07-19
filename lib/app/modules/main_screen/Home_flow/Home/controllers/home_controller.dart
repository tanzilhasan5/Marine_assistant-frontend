import 'package:get/get.dart';

class HomeController extends GetxController {
  // Location
  final locationLabel = 'CURRENT POSITION'.obs;
  final locationName = 'Tampa Bay Channel'.obs;

  // Marine conditions
  final wind = '12 kt'.obs;
  final windDir = 'Wind NE'.obs;
  final wave = '0.5 m'.obs;
  final temp = "18' C".obs;
  final visibility = '6 nm'.obs;

  // Vessel
  final vesselName = 'My Boat'.obs;
  final fuelCurrent = 140.obs;
  final fuelTotal = 200.obs;
  final nm = '0.5'.obs;
  final hrs = '0.5'.obs;
  final lh = '0.5'.obs;
  final reserve = '0.5'.obs;

  // Alerts
  final alerts = <Map<String, String>>[
    {'title': 'Shoal reported ahead', 'time': '2 min ago'},
    {'title': 'Heavy traffic near channel', 'time': '2 min ago'},
    {'title': 'Shoal reported ahead', 'time': '2 min ago'},
  ].obs;

  double get fuelPercent => fuelCurrent.value / fuelTotal.value;

  void onReport() {
    // TODO: Navigate to report screen
  }

  void onStartNavigation() {
    // TODO: Navigate to navigation/route screen
  }
}
