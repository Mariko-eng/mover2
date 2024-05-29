import 'package:flutter/material.dart';
import 'package:bus_stop_develop_admin/models/busCompany.dart';

class BusCompanyEditView extends StatefulWidget {
  final BusCompany company;
  const BusCompanyEditView({super.key, required this.company});

  @override
  State<BusCompanyEditView> createState() => _BusCompanyEditViewState();
}

class _BusCompanyEditViewState extends State<BusCompanyEditView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xfffdfdfd),
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
                width: 20,
                height: 25,
                child: Image.asset(
                  'assets/images/back_arrow.png',
                )),
          ),
          title: Text(
            widget.company.name.toUpperCase(),
            style: TextStyle(color: Colors.red[900]),
          )),
    );
  }
}
