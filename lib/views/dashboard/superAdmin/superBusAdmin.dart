import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bus_stop_develop_admin/models/user/user.dart';
import 'package:bus_stop_develop_admin/views/pages/user_account/super_admin/myAccount.dart';
import 'package:bus_stop_develop_admin/views/pages/user_account/super_admin/list.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/clients/AllClients.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/destinations/AllDestinationsList.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/notifications/AllNotifications.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/settings/SettingsScreen.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/bus_company/BusCompanyList.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/info/AdminInfoListView.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/transactions/AllTransactionsList.dart';


class DashboardSuperAdmin extends StatefulWidget {
  final AdminUserModel user;
  const DashboardSuperAdmin({Key? key,required this.user}) : super(key: key);

  @override
  _DashboardSuperAdminState createState() => _DashboardSuperAdminState();
}

class _DashboardSuperAdminState extends State<DashboardSuperAdmin> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width:55,height:45,
                        child: Image.asset("assets/images/image6.png")),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "ADMINISTRATOR".toUpperCase()
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Get.to(() => BusCompanyList());
                          },
                          child: Container(
                            height: 150,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: const Text("Bus Companies",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Get.to(() => AllDestinationsList());
                          },
                          child: Container(
                            height: 150,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: const Text("Destinations",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(height: 10,),
                Column(
                  children: [
                    Container(
                      height: 50,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Options",
                            style: TextStyle(color: Colors.red),
                          ),
                          Icon(Icons.arrow_drop_down_circle_outlined,
                            color: Colors.red,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    ListTile(
                      onTap: () {
                        Get.to(() => SuperAdminAllTransactionsList());
                      },
                      leading: Icon(Icons.receipt, color: Colors.red,),
                      title: Text("Transactions"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(),
                    const SizedBox(height: 5,),
                    ListTile(
                      onTap: () {
                        Get.to(() => SuperAllClientsListView());
                      },
                      leading: Icon(Icons.people, color: Colors.red,),
                      title: Text("Clients"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(),
                    const SizedBox(height: 5,),
                    ListTile(
                      onTap: () {
                        Get.to(() => SuperAdminInfoListView());
                      },
                      leading: Icon(Icons.info, color: Colors.red,),
                      title: Text("News & Info"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(),
                    const SizedBox(height: 5,),
                    ListTile(
                      onTap: () {
                        Get.to(() => SuperAdminNotificationsListView());
                      },
                      leading: Icon(Icons.notification_important, color: Colors.red,),
                      title: Text("Notifications"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(),
                    const SizedBox(height: 5,),
                    ListTile(
                      onTap: () {
                        Get.to(() => SuperAdminUserAccountsListView());
                      },
                      leading: Icon(Icons.people_alt_outlined, color: Colors.red,),
                      title: Text("Super User Accounts"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(),
                    const SizedBox(height: 5,),

                    ListTile(
                      onTap: () {
                        Get.to(() => SettingsScreen());
                      },
                      leading: Icon(Icons.settings, color: Colors.red,),
                      title: Text("Contact Us"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(),
                    const SizedBox(height: 5,),

                    ListTile(
                      onTap: () {
                        Get.to(() => MyAccountView());
                      },
                      leading: Icon(Icons.person, color: Colors.red,),
                      title: Text("My Account"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

