import 'dart:async';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  void initLocalNotification(BuildContext context) async {
    var androidInitialization = AndroidInitializationSettings('@mipmap/ic_launcher');  // Ensure this icon exists
    var iosInitialization = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: androidInitialization,
      iOS: iosInitialization,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        // Handle notification tapped logic here
      },
    );
  }

  Future<void> showNotification(RemoteMessage msg) async {
    const String channelId = 'high_importance_channel';
    const String channelName = 'High Importance Notifications';
    const String channelDescription = 'This channel is used for important notifications.';

    // Create the channel if necessary
    const AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
      channelId,
      channelName,
      description: channelDescription,
      importance: Importance.max,
    );

    final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      androidNotificationChannel.id,
      androidNotificationChannel.name,
      channelDescription: androidNotificationChannel.description,
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      icon: '@mipmap/ic_launcher',  // Ensure this icon exists
    );

    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      msg.messageId.hashCode,
      msg.notification?.title ?? 'No Title',
      msg.notification?.body ?? 'No Body',
      notificationDetails,
    );
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Permission Granted');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('Provisional Permission Granted');
    } else {
      print('Permission Denied');
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token ?? 'Token not available';
  }

  void handleTokenRefresh() {
    messaging.onTokenRefresh.listen((newToken) {
      print('New token: $newToken');
      // Update your server with the new token if necessary
    });
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message while in the foreground!');
      showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
      // Handle the message when the app is opened from the notification
    });

    handleTokenRefresh();
  }
}
