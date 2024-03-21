import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/reports/reports_list_view.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/bus_company/BusCompanyNew.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/bus_company/BusCompanyViewEdit.dart';
import 'package:flutter/foundation.dart';
import 'BusCompanyDestinations.dart';
import 'package:bus_stop_develop_admin/views/pages/user_account/bus_admin/list.dart';

class BusCompanyList extends StatefulWidget {
  const BusCompanyList({Key? key}) : super(key: key);

  @override
  _BusCompanyListState createState() => _BusCompanyListState();
}

class _BusCompanyListState extends State<BusCompanyList> {
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
            "All Bus Companies".toUpperCase(),
            style: TextStyle(color: Colors.red[900]),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red[900],
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BusCompanyNew()));
          },
          child: Icon(Icons.add_box,
          color: Colors.white,
          )),
      body: StreamBuilder(
        stream: getAllBusCompanies(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            if (kDebugMode) {
              print(snapshot.error);
            }
          }
          if (snapshot.hasData) {
            List<BusCompany>? data = snapshot.data;
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            )),
                        child: Column(
                          children: [
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.red[100],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  )),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onDoubleTap: () {
                                      _performDeleteCompany(data[index]);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red[900],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Name : ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(data[index].name)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Email : ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(data![index].email)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Phone Number : ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(data[index].phoneNumber)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BusReportsListView(
                                                      company: data[index],
                                                    )));
                                      },
                                      child: Container(
                                        height: 30,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "View Reports",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.blue[900],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        _openBottomSheet(company: data[index]);
                                      },
                                      child: Container(
                                        height: 30,
                                        alignment: Alignment.center,
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(
                                          "More Actions",
                                          style:
                                              TextStyle(color: Colors.red[900]),
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.red[900]!),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
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
        },
      ),
    );
  }

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

  void _openBottomSheet({required BusCompany company}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return _getTicketOptions(company: company);
        });
  }

  Widget _getTicketOptions({required BusCompany company}) {
    final options = ["Add/Edit User Accounts","View/Edit Destinations", "View/Edit Bus Company"];
    return Container(
      height: 250,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: options
            .map((option) => ListTile(
                  onTap: () => {
                    if (option == "Add/Edit User Accounts")
                      {
                        Navigator.of(context).pop(),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BusAdminUserAccountsListView(
                                      company: company,
                                    )))
                      },
                    if (option == "View/Edit Park Locations")
                      {
                        Navigator.of(context).pop(),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BusCompanyDestinationsListView(
                                      company: company,
                                    )))
                      },
                    if (option == "View/Edit Bus Company")
                      {
                        Navigator.of(context).pop(),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BusCompanyViewEdit(
                                      company: company,
                                    )))
                      }
                  },
                  title: Column(
                    children: [
                      Text(
                        option,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Color(0xFFE4191D)),
                      ),
                      SizedBox(height: 4),
                      Divider(height: 1)
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
