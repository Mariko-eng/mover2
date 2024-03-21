import 'package:bus_stop_develop_admin/views/pages/user_account/super_admin/myAccount.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bus_stop_develop_admin/controllers/authProvider.dart';
import 'package:bus_stop_develop_admin/models/user/user.dart';
import 'package:bus_stop_develop_admin/views/pages/user_account/super_admin/list.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/AllClients.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/destinations/AllDestinationsList.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/AllNotifications.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/AllTickets.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/AllTrips.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/SettingsScreen.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/bus_company/BusCompanyList.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/AdminInfoListView.dart';


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
    UserProvider userProvider = Provider.of<UserProvider>(context);
    // userProvider.getLatestNotifications();

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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Get.to(() => AllTrips());
                          },
                          child: Container(
                            height: 150,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: const Text("Trips",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Get.to(() => AllTickets());
                          },
                          child: Container(
                            height: 150,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Text("Tickets",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                            "Actions",
                            style: TextStyle(color: Colors.red),
                          ),
                          Icon(Icons.arrow_drop_down_circle_outlined,
                            color: Colors.red,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    GestureDetector(
                      onTap: (){
                        Get.to(() => AdminInfoListView());
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.arrow_right,size: 10,),
                          SizedBox(width: 10,),
                          Text("News & Info"),
                          Icon(Icons.info,color: Colors.red,),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Divider(),
                    const SizedBox(height: 5,),
                    GestureDetector(
                      onTap: (){
                        Get.to(() => AllClients());
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.arrow_right,size: 10,),
                          SizedBox(width: 10,),
                          Text("Registered Clients"),
                          Icon(Icons.people,color: Colors.red,),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Divider(),
                    const SizedBox(height: 5,),
                    GestureDetector(
                      onTap: (){
                        Get.to(() => SuperAdminUserAccountsListView());
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.arrow_right,size: 10,),
                          SizedBox(width: 10,),
                          Text("Super User Accounts"),
                          Icon(Icons.people_alt_outlined,color: Colors.red,),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Divider(),
                    const SizedBox(height: 5,),
                    GestureDetector(
                      onTap: (){
                        Get.to(() => AllSuperAdminNotifications());
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.arrow_right,size: 10,),
                          SizedBox(width: 10,),
                          Text("Notifications"),
                          Icon(Icons.notifications,color: Colors.red,),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Divider(),
                    const SizedBox(height: 5,),
                    GestureDetector(
                      onTap: (){
                        Get.to(() => MyAccountView());
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.arrow_right,size: 10,),
                          SizedBox(width: 10,),
                          Text("My Account"),
                          Icon(Icons.person,color: Colors.red,),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Divider(),
                    GestureDetector(
                      onTap: (){
                        Get.to(() => SettingsScreen());
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.arrow_right,size: 10,),
                          SizedBox(width: 10,),
                          Text("Settings/Support"),
                          Icon(Icons.settings,color: Colors.red,),
                        ],
                      ),
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

