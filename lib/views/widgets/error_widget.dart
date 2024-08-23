import 'package:flutter/material.dart';

class ErrorWidgetView extends StatelessWidget {
  const ErrorWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: Column(
        children: [
          Container(
              height: 100,
              width: 50,
              child: Image.asset("assets/images/image11.png")),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sorry, Something Went Wrong!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )
            ],
          )
        ],
      ),
    );
  }
}
