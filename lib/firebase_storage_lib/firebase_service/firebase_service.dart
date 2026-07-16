import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FBServices {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> getDeviceToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // 1. Request notification permissions (Crucial for iOS)
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // 2. Fetch the FCM token
      String? token = await messaging.getToken();
      print("--- Device FCM Token ---");
      print(token);

      // Send this token to your backend server here
    } else {
      print('User declined or has not accepted notification permissions');
    }
  }

  Future<void> localNotification() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      final data = message.data; // custom key-value pairs from sender

      final String messageType =
          data['type'] ?? 'general'; // e.g. "chat", "order", "promo"

      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
          id: notification.hashCode,
          title: notification.title,
          body: notification.body,
          notificationDetails: const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'High Importance Notifications',
              importance: Importance.max,
              icon: '@mipmap/ic_launcher',
              priority: Priority.high,
            ),
            iOS: DarwinNotificationDetails(),
          ),
          payload: data['screen'],
        );
      }
    });
  }
}
