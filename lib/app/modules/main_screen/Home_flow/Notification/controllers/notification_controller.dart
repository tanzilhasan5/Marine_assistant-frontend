import 'package:get/get.dart';

class NotificationModel {
  final String title;
  final String description;

  NotificationModel({required this.title, required this.description});
}

class NotificationController extends GetxController {
  final notifications = <NotificationModel>[
    NotificationModel(
      title: 'Rock Hazard Ahead',
      description:
          'A confirmed rock obstacle has been reported 350m ahead on your current route.',
    ),
    NotificationModel(
      title: 'Shallow Water Warning',
      description:
          'Water depth is approaching your configured safety threshold.',
    ),
    NotificationModel(
      title: 'Fishing Net Detected',
      description:
          'Community members reported fishing nets near your navigation corridor.',
    ),
    NotificationModel(
      title: 'Wreck Ahead',
      description:
          'confirmed wreck has been reported 500m ahead. Exercise caution.',
    ),
    NotificationModel(
      title: 'Low Fuel Alert',
      description:
          'Estimated fuel reserve may be insufficient to complete your trip safely.',
    ),
    NotificationModel(
      title: 'Critical Fuel Warning',
      description:
          'Fuel level has dropped below your safety reserve threshold.',
    ),
    NotificationModel(
      title: 'Fuel Station Nearby',
      description:
          'Ocean Fuel Dock is 1.2 NM away from your current position.',
    ),
  ].obs;

  void removeNotification(int index) {
    if (index >= 0 && index < notifications.length) {
      notifications.removeAt(index);
    }
  }
}
