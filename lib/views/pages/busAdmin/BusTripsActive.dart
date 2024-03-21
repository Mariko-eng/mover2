import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/trip.dart';
import 'package:bus_stop_develop_admin/models/user/user.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/BusTripsTickets.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/TripsViewEdit.dart';
import 'package:bus_stop_develop_admin/views/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusTripsActive extends StatefulWidget {
  // final AdminUserModel user;
  final BusCompany company;

  const BusTripsActive({Key? key, required this.company}) : super(key: key);

  @override
  _BusTripsActiveState createState() => _BusTripsActiveState();
}

class _BusTripsActiveState extends State<BusTripsActive> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: getActiveTripsForBusCompany(companyId: widget.company.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.hasData) {
            List<Trip>? trips = snapshot.data;
            if (trips!.isEmpty) {
              return Center(
                child: Text(
                  "No Available Trips!".toUpperCase(),
                  style: const TextStyle(color: Color(0xff62020a)),
                ),
              );
            }
            return ListView.builder(
                itemCount: trips.length,
                itemBuilder: (context, int index) => FutureBuilder(
                      future: trips[index].setCompanyData(context),
                      // ignore: missing_return
                      builder: (context, snapshot) {
                        Trip? trip = snapshot.data;
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            if (index == 0) {
                              return Container();
                            }
                            return Container();
                          case ConnectionState.none:
                            return Container();
                          case ConnectionState.active:
                            return Text('Searching... ');
                          case ConnectionState.done:
                            return trip == null
                                ? Container()
                                : Padding(
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
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10))),
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
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 25,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          await deleteTrip(
                                                              tripId: trip.id);
                                                        },
                                                        child: Icon(
                                                          Icons.delete,
                                                          color:
                                                              Colors.red[900],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
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
                                                Text(
                                                  trip.busPlateNo.toUpperCase(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
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
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.green),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
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
                                                          dateToTime(
                                                              trip.arrivalTime),
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Colors.red[900]),
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
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Price:",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                                              FontWeight.bold),
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
                                          Container(
                                            height: 50,
                                            width: double.infinity,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                // color: Colors.red[400],
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Get.to(() =>
                                                            BusCompanyTripsTickets(
                                                              company: widget
                                                                  .company,
                                                              trip: trip,
                                                            ));
                                                      },
                                                      child: Container(
                                                        height: 45,
                                                        alignment:
                                                            Alignment.center,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Colors.red[900],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Text(
                                                          "View Tickets",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Get.to(
                                                            () => TripsViewEdit(
                                                                  company: widget
                                                                      .company,
                                                                  trip: trip,
                                                                ));
                                                      },
                                                      child: Container(
                                                        height: 45,
                                                        alignment:
                                                            Alignment.center,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons.edit,
                                                              color: Colors
                                                                  .blue[800],
                                                            ),
                                                            Text(
                                                              "Edit",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                          .blue[
                                                                      900]),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                        }
                      },
                    ));
          }
          return Container();
        });
  }
}
