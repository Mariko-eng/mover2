import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/reports/index.dart';
import 'package:bus_stop_develop_admin/views/pages/user_account/bus_admin/list.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/destinations/destinations_list_view.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/trickets/BusTickets.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/trips/BusTrips.dart';


class BusCompanyDetailView extends StatefulWidget {
  final BusCompany company;

  const BusCompanyDetailView({Key? key, required this.company}) : super(key: key);

  @override
  _BusCompanyViewEditState createState() => _BusCompanyViewEditState();
}

class _BusCompanyViewEditState extends State<BusCompanyDetailView> {
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 40,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Company Profile",
                    style: TextStyle(fontSize: 18,color: Color(0xff62020a)),
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
                    Text(widget.company.email,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
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
                    Text(widget.company.email,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
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
                    Text(widget.company.phoneNumber,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
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
                  children: [const Text("HotLine"),
                    Text(widget.company.hotLine,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )],
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Divider(),
              Text("Options",
                style: TextStyle(fontSize: 18,color: Color(0xff62020a)),
              ),

              Divider(),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BusAdminTripsView(
                                company: widget.company,
                              )));
                },
                leading: Icon(Icons.bus_alert),
                title: Text("Trips"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BusAdminTicketsView(
                                company: widget.company,
                              )));
                },
                leading: Icon(Icons.airplane_ticket),
                title: Text("Tickets"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BusAdminReportsListView(
                                company: widget.company,
                              )));
                },
                leading: Icon(Icons.repeat_on_rounded),
                title: Text("Reports"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BusAdminUserAccountsListView(
                                company: widget.company,
                              )));
                },
                leading: Icon(Icons.people),
                title: Text("User Accounts"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BusAdminDestinationsListView(
                                company: widget.company,
                              )));
                },
                leading: Icon(Icons.location_city),
                title: Text("Parks/Destinations"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  _performDeleteCompany(widget.company);
                },
                leading: Icon(Icons.delete),
                title: Text("Delete Company"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(),
            ],
          ),
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


  Future<void> _performDeleteCompany(BusCompany company) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Are You Sure You Want To Delete This Company?",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  company.name.toUpperCase(),
                  style: TextStyle(color: Colors.blue[900]),
                ),
              ],
            ),
          ),
          actions: [
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  "CANCEL",
                  style: TextStyle(color: Colors.blue[900]),
                )),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
                onTap: () async {
                  Get.back();
                  await deleteBusCompany(company: company);
                  Get.back();
                },
                child: Container(
                  height: 30,
                  width: 100,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red[900]!),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "DELETE",
                    style: TextStyle(color: Color(0xffE4181D)),
                  ),
                ))
          ],
        );
      },
    );
  }

}
