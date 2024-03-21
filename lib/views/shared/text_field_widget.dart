import 'package:flutter/material.dart';

class TextFieldContainerWidget extends StatelessWidget {
  final Widget child;

  const TextFieldContainerWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      width: size.width * 0.9,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xffe5e5e5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
