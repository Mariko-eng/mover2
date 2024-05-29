import 'package:bus_stop_develop_admin/views/pages/superAdmin/bus_company/BusCompanyDetail.dart';
import 'package:flutter/material.dart';
import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/bus_company/BusCompanyNew.dart';
import 'package:flutter/foundation.dart';


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
          centerTitle: true,
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
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BusCompanyDetailView(
                                    company: data[index],
                                  )));
                        },
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
                                  children: [],
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
                                              .bodyMedium!
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
                                              .bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(data[index].email)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Phone Number : ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
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
                                                  builder: (context) => BusCompanyDetailView(
                                                    company: data[index],
                                                  )));
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
}
