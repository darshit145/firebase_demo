/*
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../main.dart';
import '../../auth/first_screen.dart';
class FirebaseApiCalss{

  final _fireBaseMassaging=FirebaseMessaging.instance;
  Future<void> initNotification()async{
    await _fireBaseMassaging.requestPermission();
    final FMCtocken=await _fireBaseMassaging.getToken();
    print("tockon:$FMCtocken");
    FirebaseMessaging.onBackgroundMessage(HandleBackgroundMassage);
    initPushNotification();

  }
  void handleMassage(RemoteMessage? msg){
    if(msg==null)return;

    navigatorKey.currentState?.pushNamed(
        FirstScreenButton.route,
      arguments: msg
    );
  }
  Future initPushNotification()async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      sound: true,
      badge: true,
      alert: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMassage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMassage);
    FirebaseMessaging.onBackgroundMessage(HandleBackgroundMassage);
  }

  final _androidChannel=const AndroidNotificationChannel(
      "high_importance_channel",
      "High Importance Notification",
      description: "hello to System",
      importance: Importance.defaultImportance
  );
}
Future<void> HandleBackgroundMassage(RemoteMessage message)async{
  print("title:"+message.notification!.body.toString());
  print("title:"+message.notification!.body.toString());
  print("title:"+message.data.toString());

}*/
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../main.dart';
import '../../auth/first_screen.dart';

class FirebaseApiClass {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    // Request permission for iOS devices
    await
    await _firebaseMessaging.requestPermission();

    // Get the FCM token
    final fcmToken = await _firebaseMessaging.getToken();
    print("Token: $fcmToken");

    // Set up background message handler
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);

    // Initialize local notifications
    await _initLocalNotification();

    // Set up push notifications
    await _initPushNotification();
  }

  Future<void> _initLocalNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
        if (notificationResponse.payload != null) {
          navigatorKey.currentState?.pushNamed(
            FirstScreenButton.route,
            arguments: notificationResponse.payload,
          );
        }
      },
    );
  }

  void handleMessage(RemoteMessage? msg) {
    if (msg == null) return;

    final notification = msg.notification;
    final data = msg.data;

    if (notification != null) {
      _showNotification(notification);
    }

    navigatorKey.currentState?.pushNamed(
      FirstScreenButton.route,
      arguments: data,
    );
  }

  Future<void> _showNotification(RemoteNotification notification) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      platformChannelSpecifics,
      payload: notification.body,
    );
  }

  Future<void> _initPushNotification() async {
    // Set notification options for foreground notifications
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle initial message when the app is launched from a terminated state
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // Handle messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen(handleMessage);

    // Handle messages when the app is brought to the foreground from the background
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
  }
}

// Background message handler
Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  // You can perform additional tasks here, like updating the UI or showing a notification
}
