import 'dart:async';
import 'package:bus_stop_develop_admin/views/auth/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeAnimation() async{
    setState(() {
      Timer.periodic(const Duration(milliseconds: 500), (Timer timer){
        timer.cancel();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) =>const Wrapper()), (route) => false);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    changeAnimation();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light); //
    return Scaffold(
      backgroundColor: const Color(0xff62020a),
      body: Container(),
    );
  }
}

