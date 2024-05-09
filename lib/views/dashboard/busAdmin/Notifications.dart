import 'package:bus_stop_develop_admin/models/Notifications.dart';
import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/views/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bus_stop_develop_admin/controllers/authProvider.dart';

class BusCompanyNotifications extends StatefulWidget {
  final BusCompany company;

  const BusCompanyNotifications({Key? key, required this.company})
      : super(key: key);

  @override
  _BusCompanyNotificationsState createState() =>
      _BusCompanyNotificationsState();
}

class _BusCompanyNotificationsState extends State<BusCompanyNotifications> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xfffdfdfd),
      appBar: AppBar(
        backgroundColor: Color(0xfffdfdfd),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Notifications",
          style: TextStyle(color: Color(0xffE4181D)),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
              width: 20,
              height: 25,
              child: Image.asset(
                'assets/images/back_arrow.png',
              )),
        ),
      ),
      body: Column(
        children: [
          Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color(0xff62020a),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                "Notifications",
                style: TextStyle(color: Colors.yellow[200]),
              )),
          StreamBuilder(
              stream: getBusCompanyNotifications(
                  companyId: userProvider.busCompany!.uid),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                if (snapshot.hasData) {
                  List<NotificationsModel>? data = snapshot.data;
                  if (data!.isEmpty) {
                    return const Center(
                      child: Text("No Notifications Yet"),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                        itemCount: data!.length,
                        itemBuilder: (context, int index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index].title.toUpperCase(),
                                    style: TextStyle(color: Colors.blue[900]),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(data[index].body),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        dateToString(data[index].dateCreated),
                                        style:
                                            TextStyle(color: Colors.blue[300]),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                } else {
                  return Container();
                }
              })
        ],
      ),
    );
  }
}
