import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bus_stop_develop_admin/models/user/user.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/main/HomeBusAdmin.dart';

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
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10),
                    child: HomeBusAdmin(),
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