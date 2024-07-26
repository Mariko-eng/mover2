import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:sail_courier_client/views/intro_view.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void initializeNotifications() async {
    IOSInitializationSettings iosInitializationSettings =
    IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: didReceiveLocalNotificationIOS);

    AndroidInitializationSettings androidPlatformChannelSpecifics =
    const AndroidInitializationSettings(
      'icon',
    );

    final InitializationSettings initializationSettings =
    InitializationSettings(
        iOS: iosInitializationSettings,
        android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }


  // void initializeNotifications() async {
  //   // final DarwinInitializationSettings initializationSettingsDarwin =
  //   // DarwinInitializationSettings(
  //   //     onDidReceiveLocalNotification: onDidReceiveLocalNotificationIOS);
  //
  //   // IOSInitializationSettings iosInitializationSettings =
  //   //     IOSInitializationSettings(
  //   //         requestAlertPermission: false,
  //   //         requestBadgePermission: false,
  //   //         requestSoundPermission: false,
  //   //         onDidReceiveLocalNotification: didReceiveLocalNotificationIOS);
  //
  //   AndroidInitializationSettings androidPlatformChannelSpecifics =
  //       AndroidInitializationSettings(
  //     'sailguy',
  //   );
  //
  //   final InitializationSettings initializationSettings =
  //       InitializationSettings(
  //           // iOS: initializationSettingsDarwin,
  //           android: androidPlatformChannelSpecifics);
  //
  //   // await flutterLocalNotificationsPlugin.initialize(
  //   //     initializationSettings,
  //   //     onDidReceiveBackgroundNotificationResponse: didReceiveLocalNotificationAndroid,
  //   //     onDidReceiveNotificationResponse: didReceiveLocalNotificationAndroid
  //   //     // onSelectNotification: didReceiveLocalNotificationAndroid
  //   // );
  // }

  Future didReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    Get.dialog(SimpleDialog(
      title: Text(title),
      children: [
        Column(
          children: [
            Text(body),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      // Get.to(() => IntroView());
                    },
                    icon: Icon(Icons.check))
              ],
            )
          ],
        )
      ],
    ));
  }

  Future didReceiveLocalNotificationIOS(
      int? id, String? title, String? body, String? payload) async {
    Get.dialog(SimpleDialog(
      title: Text(title!),
      children: [
        Column(
          children: [
            Text(body!),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      // Get.to(() => IntroView());
                    },
                    icon: Icon(Icons.check))
              ],
            )
          ],
        )
      ],
    ));
  }

  Future selectNotification(String? payload) async {
    // return Get.to(() => IntroView());
  }

  void requestIOSPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void requestAndroidPermissions() async {
    try{
      print("Requests Android Perm");
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(const AndroidNotificationChannel(
          'high_importance_channel', // id
          'High Importance Notifications', // title
          importance: Importance.high,
          playSound: true));
    }catch(e){
      printError(info: "Failed To Request Notifications Permissions");
      print(e.toString());
    }
  }

  displayNotification(int id, String title, String body) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'high_importance_channel', 'High Importance Notifications');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    try {
      await flutterLocalNotificationsPlugin
          .show(id, title, body, platformChannelSpecifics, payload: body);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> subscribeToFirebaseMessagingTopic({required String topic}) async{
    await FirebaseMessaging.instance.subscribeToTopic(topic);
  }
}
