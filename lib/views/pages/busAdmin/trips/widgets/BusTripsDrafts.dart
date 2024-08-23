import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/trip.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/trips/BusTripsEditView.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/trips/BusTripsTickets.dart';
import 'package:bus_stop_develop_admin/views/widgets/error_widget.dart';
import 'package:bus_stop_develop_admin/views/widgets/loading.dart';
import 'package:bus_stop_develop_admin/views/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusTripsDrafts extends StatefulWidget {
  // final AdminUserModel user;
  final BusCompany company;

  const BusTripsDrafts({Key? key, required this.company}) : super(key: key);

  @override
  _BusTripsDraftsState createState() => _BusTripsDraftsState();
}

class _BusTripsDraftsState extends State<BusTripsDrafts> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: busCompanyDraftTrips(companyId: widget.company.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: ErrorWidgetView());
          }
          if (!snapshot.hasData) {
            return Center(child: LoadingWidget());
          } else {
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
                itemBuilder: (context, int index) {
                  Trip trip = trips[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.red[100],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(trip.tripType.toUpperCase()),
                                  // Row(
                                  //   children: [
                                  //     SizedBox(
                                  //       width: 25,
                                  //     ),
                                  //     GestureDetector(
                                  //       onTap: () async {
                                  //         _showActionDialog(
                                  //             tripId: 'trip.id',
                                  //           performAction: deleteTrip
                                  //         );
                                  //       },
                                  //       child: Icon(
                                  //         Icons.delete,
                                  //         color:
                                  //         Colors.red[900],
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                const Text(
                                  "Trip:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Text(
                                  "From:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Row(
                                  children: [
                                    Text(trip.departureLocationName),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.lock_clock,
                                      size: 15,
                                    ),
                                    Text(
                                      dateToStringNew(trip.departureTime) +
                                          "/" +
                                          dateToTime(trip.departureTime),
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.green),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Text(
                                  "To:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Row(
                                  children: [
                                    Text(trip.arrivalLocationName),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.lock_clock,
                                      size: 15,
                                    ),
                                    Text(
                                      dateToStringNew(trip.arrivalTime) +
                                          "/" +
                                          dateToTime(trip.arrivalTime),
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.red[900]),
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Price:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(trip.priceOrdinary.toString() + " SHS")
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Discount Price: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(trip.discountPriceOrdinary.toString() +
                                        " SHS")
                                  ],
                                ),
                              ],
                            ),
                          ),
                          trip.tripType != "Ordinary"
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "VIP Price: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              trip.priceVip.toString() + " SHS")
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "VIP Discount Price: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              trip.discountPriceVip.toString() +
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
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => BusTripsEditView(
                                              company: widget.company,
                                              trip: trip,
                                            ));
                                      },
                                      child: Container(
                                        height: 45,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              color: Colors.blue[800],
                                            ),
                                            Text(
                                              "Edit Trip",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.blue[900]),
                                            )
                                          ],
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
                                        _openBottomSheet(trip: trip);
                                      },
                                      child: Container(
                                        height: 45,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.red[900],
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          "More Options",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
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
                });
          }
        });
  }

  void _openBottomSheet({required Trip trip}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return _getOptions(trip: trip);
        });
  }

  Widget _getOptions({required Trip trip}) {
    var options = [
      "View Tickets",
      "Publish Trip",
      "Delete Trip",
    ];
    return Container(
      height: 300,
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: options
            .map((option) => ListTile(
                  onTap: () => {
                    if (option == "View Tickets")
                      {
                        Navigator.of(context).pop(),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BusCompanyTripsTickets(
                                      company: widget.company,
                                      trip: trip,
                                    )))
                      },
                    if (option == "Publish Trip")
                      {
                        Navigator.of(context).pop(),
                        _showActionDialog(
                            trip: trip,
                            dialogMessage: "Are You Sure You Want To Publish?",
                            performAction: () async {
                              await editTripUnDraft(trip: trip);
                              await editTripPublish(trip: trip);
                            })
                      },
                    if (option == "Delete Trip")
                      {
                        Navigator.of(context).pop(),
                        _showActionDialog(
                            trip: trip,
                            dialogMessage: "Are You Sure You Want To Delete?",
                            performAction: () {
                              deleteTrip(tripId: trip.id);
                            }
                            // performAction: deleteTrip
                            )
                      },
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

  void _showActionDialog(
      {required Trip trip,
      required String dialogMessage,
      required Function performAction}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(builder: (context) {
                var height = 50.0;
                var width = MediaQuery.of(context).size.width * 0.8;

                return Container(
                  height: height,
                  width: width,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          dialogMessage,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            width: 100,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "NO",
                              style: TextStyle(
                                fontSize: 17,
                                color: Theme.of(context).primaryColor,
                              ),
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          Navigator.of(context).pop();
                          await performAction();
                          // await performAction(tripId: trip.id);
                        },
                        child: Container(
                            width: 100,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text("Continue",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                ))),
                      ),
                    )
                  ],
                )
              ],
            );
          });
        });
  }
}
