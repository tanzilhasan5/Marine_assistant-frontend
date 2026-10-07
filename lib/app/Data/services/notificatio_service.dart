import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

/// Handles all OneSignal push-notification setup:
/// initialization, foreground display, click handling,
/// permission request, and subscription info logging.
class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  static const String _oneSignalAppId =
      "bb04c0fa-2bee-4591-a9f6-b45055781a4b";

  /// Call once from main() before runApp().
  Future<void> init() async {
    try {
      // Enable OneSignal debug logs
      OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

      // Initialize OneSignal
      OneSignal.initialize(_oneSignalAppId);

      debugPrint("OneSignal initialized");

      _registerForegroundListener();
      _registerClickListener();

      await _requestPermission();
      _logSubscriptionInfo();
    } catch (e, stackTrace) {
      debugPrint("OneSignal init error: $e");
      debugPrint("$stackTrace");
    }
  }

  // ------------------------------------------------------------
  // FOREGROUND NOTIFICATION
  // ------------------------------------------------------------
  void _registerForegroundListener() {
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      debugPrint("========================================");
      debugPrint("ONESIGNAL FOREGROUND NOTIFICATION");
      debugPrint("========================================");

      debugPrint("Notification ID: ${event.notification.notificationId}");
      debugPrint("Title: ${event.notification.title}");
      debugPrint("Body: ${event.notification.body}");
      debugPrint("Additional Data: ${event.notification.additionalData}");

      // IMPORTANT:
      // Do NOT call preventDefault().
      //
      // display() tells OneSignal to show the
      // notification while the app is in foreground.
      event.notification.display();

      debugPrint("OneSignal notification display() called");
    });
  }

  // ------------------------------------------------------------
  // NOTIFICATION CLICK
  // ------------------------------------------------------------
  void _registerClickListener() {
    OneSignal.Notifications.addClickListener((event) {
      debugPrint("========================================");
      debugPrint("ONESIGNAL NOTIFICATION CLICKED");
      debugPrint("========================================");

      debugPrint("Notification ID: ${event.notification.notificationId}");
      debugPrint("Title: ${event.notification.title}");
      debugPrint("Body: ${event.notification.body}");
      debugPrint("Additional Data: ${event.notification.additionalData}");

      _handleNotificationOpened(event.notification.additionalData);
    });
  }

  /// Routes to the right screen when a notification is tapped.
  ///
  /// On iOS, a cold-start tap can fire this listener before
  /// GetMaterialApp's navigator exists yet, so we wait until
  /// Get's navigator key is actually attached before navigating.
  void _handleNotificationOpened(Map<String, dynamic>? data) {
    _waitUntilNavigatorReady(() {
      if (data == null) return;

      final String? screen = data['screen'] as String?;

      switch (screen) {
        case 'home':
          Get.toNamed('/home');
          break;
        case 'chat':
          final String? chatId = data['chat_id'] as String?;
          Get.toNamed('/chat', arguments: {'chat_id': chatId});
          break;
        default:
          debugPrint("No matching route for screen: $screen");
      }
    });
  }

  void _waitUntilNavigatorReady(VoidCallback action, {int attempt = 0}) {
    final bool isReady = Get.key.currentState != null;

    if (isReady) {
      action();
      return;
    }

    // Give the app a moment to finish building (cold-start case),
    // retrying a few times before giving up.
    if (attempt >= 20) {
      debugPrint("Navigator never became ready for notification click");
      return;
    }

    Future.delayed(const Duration(milliseconds: 200), () {
      _waitUntilNavigatorReady(action, attempt: attempt + 1);
    });
  }

  // ------------------------------------------------------------
  // REQUEST NOTIFICATION PERMISSION
  // ------------------------------------------------------------
  Future<void> _requestPermission() async {
    final bool permission =
    await OneSignal.Notifications.requestPermission(true);

    debugPrint("OneSignal notification permission: $permission");
  }

  // ------------------------------------------------------------
  // GET SUBSCRIPTION INFORMATION
  // ------------------------------------------------------------
  void _logSubscriptionInfo() {
    final String? subscriptionId = OneSignal.User.pushSubscription.id;
    final String? pushToken = OneSignal.User.pushSubscription.token;
    final bool? optedIn = OneSignal.User.pushSubscription.optedIn;

    debugPrint("OneSignal Subscription ID: $subscriptionId");
    debugPrint("OneSignal Push Token: $pushToken");
    debugPrint("OneSignal Opted In: $optedIn");
  }
}