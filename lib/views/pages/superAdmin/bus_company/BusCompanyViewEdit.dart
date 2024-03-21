import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_stop_develop_admin/config/collections/index.dart';

class BusCompanyViewEdit extends StatefulWidget {
  final BusCompany company;

  const BusCompanyViewEdit({Key? key, required this.company}) : super(key: key);

  @override
  _BusCompanyViewEditState createState() => _BusCompanyViewEditState();
}

class _BusCompanyViewEditState extends State<BusCompanyViewEdit> {
  bool isLoading = false;
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
      body: Card(
        child: Column(
          children: [
            Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0xff62020a),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Bus Company Profile",
                  style: TextStyle(color: Colors.yellow[200]),
                )),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text("Name"), Text(widget.company.name)],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Account Email"),
                  Text(widget.company.email)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Contact Email"),
                  Text(widget.company.email)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Phone"),
                  Text(widget.company.phoneNumber)
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text("HotLine"), Text(widget.company.hotLine)],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: isLoading
            //       ? Container(
            //           height: 40,
            //           alignment: Alignment.center,
            //           child: CircularProgressIndicator(
            //             color: Colors.red,
            //           ),
            //         )
            //       : GestureDetector(
            //           onTap: () async {
            //             setState(() {
            //               isLoading = true;
            //             });
            //             DocumentSnapshot doc = await AppCollections
            //                 .adminAccountsRef
            //                 .doc(widget.company.uid)
            //                 .get();
            //             String password = doc.get("password");
            //             setState(() {
            //               isLoading = false;
            //             });
            //             showPassword(password);
            //           },
            //           child: Container(
            //             height: 40,
            //             alignment: Alignment.center,
            //             decoration: BoxDecoration(
            //                 color: Colors.yellow[200],
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Text(
            //               "View Password".toUpperCase(),
            //               style: const TextStyle(
            //                 fontSize: 17,
            //                 color: Color(0xff62020a),
            //               ),
            //             ),
            //           ),
            //         ),
            // ),
          ],
        ),
      ),
    );
  }

  // Future<void> showPassword(String message) {
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         content: Container(
  //           margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
  //           width: double.infinity,
  //           height: 50,
  //           child: Text(message),
  //         ),
  //         actions: [
  //           const SizedBox(
  //             width: 5,
  //           ),
  //           GestureDetector(
  //               onTap: () {
  //                 Get.back();
  //               },
  //               child: const Text(
  //                 "OK",
  //                 style: TextStyle(color: Color(0xffE4181D)),
  //               ))
  //         ],
  //       );
  //     },
  //   );
  // }
}
