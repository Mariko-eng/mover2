import 'package:bus_stop_develop_admin/views/pages/superAdmin/AdminInfoNewView.dart';
import 'package:flutter/material.dart';

class AdminInfoListView extends StatefulWidget {
  const AdminInfoListView({super.key});

  @override
  State<AdminInfoListView> createState() => _AdminInfoListViewState();
}

class _AdminInfoListViewState extends State<AdminInfoListView> {
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
            "News & Info".toUpperCase(),
            style: TextStyle(color: Colors.red[900]),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red[900],
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AdminInfoNewView()));
          },
          child: Icon(Icons.add_box,
            color: Colors.white,
          )),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
