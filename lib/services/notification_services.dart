// import 'dart:io';
// import 'dart:math';

// import 'package:app_settings/app_settings.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationServices {
//   FirebaseMessaging message = FirebaseMessaging.instance;

//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   void requestNotificationspermissions() async {
//     NotificationSettings settings = await message.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: true,
//       carPlay: true,
//       criticalAlert: true,
//       provisional: true,
//       sound: true,
//     );
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print("User granted permmissions");
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       print("user granted provisional permissions");
//     } else {
//       AppSettings.openAppSettings();
//       print("user denied permissions");
//     }
//   }

//   void initLocalNotifications(
//       BuildContext context, RemoteMessage message) async {
//     var androidInitializationSettings =
//         AndroidInitializationSettings("@mipmap/ic_launcher");
//     var iosInitializationSettings = DarwinInitializationSettings();

//     var initilizationSetting = InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: iosInitializationSettings,
//     );
//     await _flutterLocalNotificationsPlugin.initialize(initilizationSetting,
//         onDidReceiveNotificationResponse: (payload) {});
//   }

//   void firebaseInit(BuildContext context) {
//     FirebaseMessaging.onMessage.listen((message) {
//       print("in firerbasein int notificcations");
//       if (kDebugMode) {
//         print(message.notification!.title.toString());
//         print(message.notification!.body.toString());
//       }
//       if (Platform.isAndroid) {
//         initLocalNotifications(context, message);
//         showNotifications(message);
//       }
//       // initLocalNotifications(context, message);
//       // showNotifications(message);
//     });
//   }

//   Future<void> showNotifications(RemoteMessage message) async {
//     AndroidNotificationChannel androidNotificationChannel =
//         AndroidNotificationChannel(Random.secure().nextInt(10000).toString(),
//             "high_importance_channel",
//             importance: Importance.high);
//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       androidNotificationChannel.id,
//       androidNotificationChannel.name,
//       channelDescription: "high_importance_channel",
//       importance: Importance.high,
//       priority: Priority.high,
//       ticker: "ticker",
//       enableVibration: true,
//     );

//     DarwinNotificationDetails darwinNotificationDetails =
//         DarwinNotificationDetails(
//       presentBadge: true,
//       // badgeNumber: 1,
//       // badgeNumber: 1,
//       presentSound: true,
//     );
//     NotificationDetails notificationDetails = NotificationDetails(
//         android: androidNotificationDetails, iOS: darwinNotificationDetails);

//     Future.delayed(Duration.zero, () {
//       _flutterLocalNotificationsPlugin.show(
//           0,
//           message.notification!.title.toString(),
//           message.notification!.body.toString(),
//           notificationDetails);
//     });
//   }

//   Future<String> getDeviceToken() async {
//     String? token = await message.getToken();
//     return token!;
//   }

//   void isTokenrefresh() async {
//     message.onTokenRefresh.listen((event) {
//       event.toString();
//       print("refreshed");
//     });
//   }
// }
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  initLocalNotifications(BuildContext context, RemoteMessage message) async {
    var androidInitialization =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosInitialization = const DarwinInitializationSettings();
    var initializationsettings = InitializationSettings(
        android: androidInitialization, iOS: iosInitialization);
    await _flutterLocalNotificationsPlugin.initialize(initializationsettings,
        onDidReceiveNotificationResponse: (payload) {});
  }

  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("allowed permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("provisional permission");
    } else {
      print("denied permission");
    }
  }

  Future<String> getDevicetoken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  firebasenotificationinit() {
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.high,
        playSound: true);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            channel.id.toString(), channel.name.toString(),
            channelDescription: channel.description,
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
            icon: "@mipmap/ic_launcher");
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          message.notification.hashCode,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  Future<void> processcompleteNotification(String message) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.high,
        playSound: true);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            channel.id.toString(), channel.name.toString(),
            channelDescription: channel.description,
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
            icon: "@mipmap/ic_launcher");
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          1, "Split Beat".toString(), message..toString(), notificationDetails);
    });
  }
}
