import 'dart:async';
import 'package:bus_stop_develop_admin/views/welcome/splashScreen.dart';
import 'package:flutter/material.dart';

class Initial extends StatefulWidget {
  const Initial({Key? key}) : super(key: key);

  @override
  _InitialState createState() => _InitialState();
}

class _InitialState extends State<Initial> with SingleTickerProviderStateMixin {
  Widget _myAnimatedWidget = const InitialWidget();
  final List<Widget> _widgets = [
    const InitialWidget(),
    FirstWidget(),
    const SecondWidget(),
    const ThirdWidget(),
    const FourthWidget(),
    const FifthWidget(),
  ];
  int i = 0;

  changeAnimation() async {
    setState(() {
      Timer.periodic(const Duration(milliseconds: 700), (Timer timer) {
        setState(() {
          i = i + 1;
          _myAnimatedWidget = _widgets[i];
        });
        if (i == 5) {
          timer.cancel();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SplashScreen()));
        }
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
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SafeArea(
        child: Stack(
          children: [
            const Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(50.0),
                  child: Text("travel made easy"),
                )),
            Center(
              child: Container(
                child: AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: Tween<double>(
                        begin: 0.0,
                        end: 1.0,
                      ).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.fastOutSlowIn,
                        ),
                      ),
                      child: child,
                    );
                  },
                  child: _myAnimatedWidget,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InitialWidget extends StatelessWidget {
  const InitialWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffffffff),
      ),
    );
  }
}

class FirstWidget extends StatelessWidget {
  const FirstWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 200.0,
      child: Center(child: Image.asset('assets/images/image1.png')),
    );
  }
}

class FifthWidget extends StatelessWidget {
  const FifthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff62020a),
    );
  }
}

class SecondWidget extends StatelessWidget {
  const SecondWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 200.0,
      child: Center(child: Image.asset('assets/images/image7.png')),
    );
  }
}

class ThirdWidget extends StatelessWidget {
  const ThirdWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 200.0,
      child: Center(child: Image.asset('assets/images/image6.png')),
    );
  }
}

class FourthWidget extends StatelessWidget {
  const FourthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 200.0,
      child: Center(child: Image.asset('assets/images/image5.png')),
    );
  }
}
