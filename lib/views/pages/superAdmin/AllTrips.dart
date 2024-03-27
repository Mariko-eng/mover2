import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/trip.dart';
import 'package:bus_stop_develop_admin/views/shared/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/utils.dart';

class AllTrips extends StatefulWidget {
  const AllTrips({Key? key}) : super(key: key);

  @override
  _TripsState createState() => _TripsState();
}

class _TripsState extends State<AllTrips> {
  BusCompany? busCompany;

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
            "Trips".toUpperCase(),
            style: TextStyle(color: Colors.red[900]),
          )),
      body: FutureBuilder(
          future: fetchBusCompanies(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Something Went Wrong!"),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: LoadingWidget(),
              );
            } else {
              List<BusCompany>? companies = snapshot.data;
              if (companies == null) {
                return Container();
              }
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              _showSelectDialog(companies: companies!);
                            },
                            child: Container(
                              height: 40,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Expanded(child: Text("Select Bus Company")),
                                  Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  busCompany != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    busCompany!.name.toUpperCase() +
                                        " " +
                                        "Trips".toUpperCase(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  )
                                ],
                              ),
                              Divider(),
                            ],
                          ),
                        )
                      : Container(),
                  busCompany == null
                      ? Container()
                      : StreamBuilder(
                          stream: getAllTripsForBusCompany(
                              companyId: busCompany!.uid),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              if (kDebugMode) {
                                print(snapshot.error);
                                return Expanded(
                                  child: const Center(
                                    child: Text("Something Went Wrong!"),
                                  ),
                                );
                              }
                            }
                            if (!snapshot.hasData) {
                              return Expanded(child: Center(child: LoadingWidget()));
                            } else {
                              List<Trip>? trips = snapshot.data;
                              if (trips == null) {
                                return Container();
                              }
                              if (trips.isEmpty) {
                                return Expanded(
                                  child: Center(
                                    child: Text("No Trips For Now!"),
                                  ),
                                );
                              } else {
                                return Expanded(
                                  child: ListView.builder(
                                    itemCount: trips.length,
                                    itemBuilder: (context, int i) {
                                      Trip trip = trips[i];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200]),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color: Colors.red[100],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(trip.tripType
                                                          .toUpperCase()),
                                                      // Row(
                                                      //   children: [
                                                      //     SizedBox(width: 25,),
                                                      //     GestureDetector(
                                                      //       onTap: () async{
                                                      //         await deleteTrip(tripId: trip.id);
                                                      //       },
                                                      //       child: Icon(Icons.delete,
                                                      //         color: Colors.red[900],
                                                      //       ),
                                                      //     )
                                                      //   ],
                                                      // )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Trip:",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(trip.tripNumber)
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "From:",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(trip
                                                            .departureLocationName),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Icon(
                                                          Icons.lock_clock,
                                                          size: 15,
                                                        ),
                                                        Text(
                                                          dateToStringNew(trip
                                                                  .departureTime) +
                                                              "/" +
                                                              dateToTime(trip
                                                                  .departureTime),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .green),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "To:",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(trip
                                                            .arrivalLocationName),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Icon(
                                                          Icons.lock_clock,
                                                          size: 15,
                                                        ),
                                                        Text(
                                                          dateToStringNew(trip
                                                                  .arrivalTime) +
                                                              "/" +
                                                              dateToTime(trip
                                                                  .arrivalTime),
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .red[900]),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "Price:",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(trip.priceOrdinary
                                                                .toString() +
                                                            " SHS")
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Discount Price: ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(trip
                                                                .discountPriceOrdinary
                                                                .toString() +
                                                            " SHS")
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              trip.tripType != "Ordinary"
                                                  ? Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "VIP Price: ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(trip.priceVip
                                                                      .toString() +
                                                                  " SHS")
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "VIP Discount Price: ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(trip
                                                                      .discountPriceVip
                                                                      .toString() +
                                                                  " SHS")
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                            }
                            // return Center(child: Loading());
                          },
                        ),
                ],
              );
            }
          }),
    );
  }

  Future<void> _showSelectDialog({required List<BusCompany> companies}) async {
    await Get.defaultDialog(
        title: "Select Company",
        titleStyle: const TextStyle(
            color: Colors.red, fontSize: 15, fontWeight: FontWeight.w600),
        barrierDismissible: true,
        content: SizedBox(
          height: 200,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...companies
                    .map((item) => Container(
                          child: Card(
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  busCompany = item;
                                });
                                Get.back();
                              },
                              title: Text(item.name),
                            ),
                          ),
                        ))
                    .toList()
              ],
            ),
          ),
        ));
  }
}
