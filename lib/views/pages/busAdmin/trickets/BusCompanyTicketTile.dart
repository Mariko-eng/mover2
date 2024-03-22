import 'package:bus_stop_develop_admin/models/ticket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../shared/utils.dart';
import 'package:bus_stop_develop_admin/config/collections/index.dart';

class BusCompanyTicketTile extends StatefulWidget {
  final TripTicket tripTicket;

  const BusCompanyTicketTile({Key? key, required this.tripTicket})
      : super(key: key);

  @override
  _TicketTileState createState() => _TicketTileState();
}

class _TicketTileState extends State<BusCompanyTicketTile> {
  String companyName = "Bus Stop";

  getCompanyInfo() async {
    if (widget.tripTicket.trip != null) {
      String docId = widget.tripTicket.trip!.company.id;
      try {
        DocumentSnapshot snap =
            await AppCollections.companiesRef.doc(docId).get();
        Map data = snap.data() as Map;
        if (data == null) {
          if (mounted) {
            setState(() {
              companyName = "Bus Stop";
            });
          }
        } else if (mounted) {
          setState(() {
            companyName = data["name"] ?? "Bus Stop";
            // companyName = snap.get("name") ?? "Bus Stop";
          });
        }
      } catch (e) {
        print(e.toString());
        if (mounted) {
          setState(() {
            companyName = "Bus Stop";
          });
        }
      }
    } else {
      await AppCollections.ticketsRef.doc(widget.tripTicket.ticketId).delete();
    }
    if (widget.tripTicket.ticketNumber == null) {
      await AppCollections.ticketsRef.doc(widget.tripTicket.ticketId).delete();
    }
  }

  @override
  void initState() {
    super.initState();
    // getCompanyInfo();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.red,
                )),
            child: Stack(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            )),
                        child: Column(
                          children: [
                            Container(
                              height: 40,
                              alignment: Alignment.center,
                              child: Text(
                                widget.tripTicket.ticketNumber.toUpperCase(),
                                style: TextStyle(color: Colors.white),
                              ),
                              decoration: const BoxDecoration(
                                  color: Color(0xffE4181D),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10))),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(dateToTime(
                                        widget.tripTicket.trip!.departureTime)),
                                    Text(dateToTime(
                                        widget.tripTicket.trip!.arrivalTime)),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: Color(0xffED696C),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color: Colors.white, width: 2)),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 3,
                                        // width: 10,
                                        color: Color(0xffED696C),
                                      ),
                                    ),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: Color(0xffED696C),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color: Colors.white, width: 2)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Text(
                                          widget.tripTicket.departureLocation),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 3,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                          widget.tripTicket.arrivalLocation),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Date"),
                                      Text(dateToStringNew(widget
                                          .tripTicket.trip!.departureTime))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Ticket Price"),
                                          Text(widget.tripTicket.trip!.price
                                                  .toString() +
                                              " SHS"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("Amount Paid"),
                                          Text(
                                            widget.tripTicket.total.toString() +
                                                " SHS",
                                            style: TextStyle(
                                                color: Colors.blue[700]),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text("Number Of Tickets"),
                                  Container(
                                      width: 50,
                                      height: 40,
                                      alignment: Alignment.center,
                                      // color: Color(0xffED696C),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.person,
                                            color: Colors.grey,
                                            size: 15,
                                          ),
                                          Text(
                                            widget.tripTicket.numberOfTickets
                                                .toString(),
                                            style: TextStyle(
                                                color: Color(0xffED696C),
                                                fontSize: 20),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 5),
                                child: Text(companyName.toUpperCase())),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                    bottom: 15,
                    left: -10,
                    child: Container(
                      width: 35,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: widget.tripTicket.status == "pending"
                              ? Colors.green
                              : Colors.blue,
                          borderRadius: BorderRadius.circular(40)),
                      child: Text(
                        widget.tripTicket.status == "pending" ? "Y" : "x",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
