import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:bus_stop_develop_admin/services/notifications.dart';
import 'package:bus_stop_develop_admin/config/collections/index.dart';
import 'package:bus_stop_develop_admin/controllers/authProvider.dart';
import 'package:bus_stop_develop_admin/controllers/locProvider.dart';
import 'package:bus_stop_develop_admin/views/auth/wrapper.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A BusStop background message showed up :  ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  AppCollections();
  runApp(const BusStopAdminApp());
}

class BusStopAdminApp extends StatefulWidget {
  const BusStopAdminApp({super.key});

  @override
  State<BusStopAdminApp> createState() => _BusStopAppState();
}

class _BusStopAppState extends State<BusStopAdminApp> {
  // late NotificationService notifyHelper;

  @override
  void initState() {
    NotificationService notifyHelper = NotificationService();
    notifyHelper.initializeNotifications();
    notifyHelper.requestIOSPermissions();
    notifyHelper.requestAndroidPermissions();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      notifyHelper.displayNotification(
        notification.hashCode,
        notification!.title!,
        notification.body!,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>.value(value: UserProvider()),
        ChangeNotifierProvider<LocationsProvider>.value(
            value: LocationsProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Bus Stopper",
        theme: ThemeData(
            primaryColor: Colors.red,
            primarySwatch: Colors.red
        ),
        home: const Wrapper(),
        // home: const Initial(),
      ),
    );
  }
}


// class BusStopAdminApp extends StatelessWidget {
//   const BusStopAdminApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<UserProvider>.value(value: UserProvider()),
//         ChangeNotifierProvider<LocationsProvider>.value(
//             value: LocationsProvider()),
//       ],
//       child: GetMaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: "Bus Stopper",
//         theme: ThemeData(
//           primaryColor: Colors.red,
//             primarySwatch: Colors.red
//         ),
//         home: const Wrapper(),
//         // home: const Initial(),
//       ),
//     );
//   }
// }
