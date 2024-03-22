import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/trips/BusTripsActive.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/trips/BusTripsNewMixed.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/trips/BusTripsNonActive.dart';
import 'package:flutter/material.dart';

class BusTrips extends StatefulWidget {
  final BusCompany company;
  const BusTrips({Key? key,required this.company}) : super(key: key);

  @override
  _BusTripsState createState() => _BusTripsState();
}

class _BusTripsState extends State<BusTrips> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xfffdfdfd),
            elevation: 0,
            centerTitle: true,
            title: const Text(
              "Company Trips",
              style: TextStyle(color: Color(0xffE4181D)),
            ),
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
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.red[900],
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BusTripsNewMixed(
                          company: widget.company,
                        )));
              },
              child: Icon(Icons.add_box)
          ),
          body: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: const BoxDecoration(
                    color: Color(0xfffeecea),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30))),
                child: const TabBar(labelColor: Color(0xff8c2636), tabs: [
                  Tab(
                    text: "ACTIVE TRIPS",
                  ),
                  Tab(
                    text: "INACTIVE TRIPS",
                  ),
                ]),
              ),
              Expanded(
                child: TabBarView(
                    children: [
                      BusTripsActive(
                        company: widget.company,
                      ),
                      BusTripsNonActive(
                        company: widget.company,
                      )
                    ]),
              )
            ],

          ),
        ));
  }
}
