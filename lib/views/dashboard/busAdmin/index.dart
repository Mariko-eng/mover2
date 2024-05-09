import 'package:bus_stop_develop_admin/views/pages/busAdmin/transactions/list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:bus_stop_develop_admin/models/user/user.dart';
import 'package:bus_stop_develop_admin/controllers/authProvider.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/trickets/BusTickets.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/trips/BusTrips.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/destinations/destinations_list_view.dart';
import 'package:bus_stop_develop_admin/views/dashboard/busAdmin/BusCompanyProfile.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/TicketNumberVerify.dart';
import 'package:bus_stop_develop_admin/views/dashboard/busAdmin/Notifications.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/reports/reports_list_view.dart';
import 'package:bus_stop_develop_admin/views/pages/user_account/bus_admin/list.dart';

class DashboardBusAdmin extends StatefulWidget {
  final AdminUserModel user;
  const DashboardBusAdmin({Key? key, required this.user}) : super(key: key);

  @override
  _DashboardAdminState createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardBusAdmin> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xfffeecea),
      body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.white,
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              width:55,height:45,
                              child: Image.asset("assets/images/image6.png")),
                          Text(widget.user.name.toUpperCase(),
                            style: TextStyle(
                                color: Color(0xff62020a)
                            ),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          FirebaseAuth.instance.signOut();
                        },
                        child: Row(
                          children: [
                            Icon(Icons.logout,
                                color: Colors.yellow[900]
                            ),
                            Text("Logout",
                              style: TextStyle(
                                  color: Colors.yellow[900]
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10),
                    child:
                    userProvider.busCompany == null
                        ? Container()
                        :
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => BusTrips(
                                        company: userProvider.busCompany!,
                                      ));
                                    },
                                    child: Container(
                                      height: 120,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: const Color(0xff62020a),
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xff62020a).withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(
                                                  0, 3), // changes position of shadow
                                            ),
                                          ]),
                                      child: const Text(
                                        "Trips",
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => BusCompanyTickets(
                                        company: userProvider.busCompany!,
                                      ));
                                    },
                                    child: Container(
                                      height: 120,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: const Color(0xff62020a),
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xff62020a).withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(
                                                  0, 3), // changes position of shadow
                                            ),
                                          ]),
                                      child: const Text(
                                        "Tickets",
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => BusDestinationsListView(
                                        company: userProvider.busCompany!,
                                      ));
                                    },
                                    child: Container(
                                      height: 120,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: const Color(0xff62020a),
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xff62020a).withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(
                                                  0, 3), // changes position of shadow
                                            ),
                                          ]),
                                      child: const Text(
                                        "Destinations",
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => BusReportsListView(
                                        company: userProvider.busCompany!,
                                      ));
                                    },
                                    child: Container(
                                      height: 120,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: const Color(0xff62020a),
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xff62020a).withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(
                                                  0, 3), // changes position of shadow
                                            ),
                                          ]),
                                      child: const Text(
                                        "Reports",
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 50,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Options",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down_circle_outlined,
                                        color: Colors.red,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Get.to(() => BusAdminTransactionsListView(
                                        company: userProvider.busCompany!,
                                      ));
                                    },
                                    leading: const Icon(
                                      Icons.receipt,
                                      color: Colors.red,
                                      size: 15,
                                    ),
                                    title: const Text("Transactions"),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Get.to(() => TicketNumberVerify(
                                        company: userProvider.busCompany!,
                                      ));
                                    },
                                    leading: const Icon(
                                      Icons.numbers,
                                      color: Colors.red,
                                      size: 15,
                                    ),
                                    title: const Text("Verify Ticket"),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Get.to(() => BusAdminUserAccountsListView(
                                        company: userProvider.busCompany!,
                                      ));
                                    },
                                    leading: const Icon(
                                      Icons.receipt,
                                      color: Colors.red,
                                      size: 15,
                                    ),
                                    title: const Text("User Accounts"),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Get.to(() => BusCompanyNotifications(
                                        company: userProvider.busCompany!,
                                      ));
                                    },
                                    leading: const Icon(
                                      Icons.notification_important,
                                      color: Colors.red,
                                      size: 15,
                                    ),
                                    title: const Text("Notifications"),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Get.to(() => BusCompanyProfile(
                                        company: userProvider.busCompany!,
                                      ));
                                    },
                                    leading: const Icon(
                                      Icons.account_circle,
                                      color: Colors.red,
                                      size: 15,
                                    ),
                                    title: const Text("Account Settings"),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // child: _widgets[selectedIndex],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}