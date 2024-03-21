import 'package:bus_stop_develop_admin/controllers/authProvider.dart';
import 'package:bus_stop_develop_admin/controllers/locProvider.dart';
import 'package:bus_stop_develop_admin/views/auth/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const BusStopAdminApp());
}

class BusStopAdminApp extends StatelessWidget {
  const BusStopAdminApp({Key? key}) : super(key: key);

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
