import 'package:bus_stop_develop_admin/models/settingsProfile.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/SettingsEditScreen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: profileSettings(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.hasData) {
            ProfileSettings? data = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Profile"),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
              floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.green[900],
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsEditScreen(settings: data!,)));
                  },
                  child: Icon(Icons.edit)
              ),
              body: Card(
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Email (1)"),
                          Text(data!.email1)
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Email (2)"),
                          Text(data.email2)
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Contact Phone (1)"),
                          Text(data.phone1)
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Contact Phone (2)"),
                          Text(data.phone2)
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("HotLine (1)"),
                          Text(data.hotline1)
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("HotLine (2)"),
                          Text(data.hotline2)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Container(),
            );
          }
        });
  }
}
