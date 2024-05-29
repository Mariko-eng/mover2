import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/ticket.dart';
import 'package:bus_stop_develop_admin/views/shared/loading.dart';
import '../../../shared/utils.dart';

class BusAdminTicketTileWidget extends StatefulWidget {
  final BusCompany company;
  final TripTicket tripTicket;

  const BusAdminTicketTileWidget(
      {Key? key,
      required this.company,
      required this.tripTicket})
      : super(key: key);

  @override
  _TicketTileState createState() => _TicketTileState();
}

class _TicketTileState extends State<BusAdminTicketTileWidget> {
  TextEditingController _ctr = TextEditingController();
  bool isUpdating = false;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isUpdating
        ? const SizedBox(
            width: 300,
            height: 310,
            child: Center(
              child: LoadingWidget(),
            ),
          )
        : GestureDetector(
            onTap: () {
              if (widget.tripTicket.status != "used") {
                _openBottomSheet(
                  company: widget.company,
                  tripTicket: widget.tripTicket,
                  companyName: widget.company.name,
                  tripPrice: widget.tripTicket.trip!.price.toString(),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 220,
                decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.tripTicket.ticketType,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    widget.tripTicket.ticketNumber,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontSize: 17,
                                            color: Colors.yellow[100],
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.red[900],
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  widget.tripTicket.status.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 15, color: Colors.white),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  child: Icon(
                                    Icons.calendar_today,
                                    color: Colors.yellow,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    dateToStringNew(
                                        widget.tripTicket.trip!.departureTime),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ))
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  child: Icon(
                                    Icons.monetization_on,
                                    color: Colors.blue[900],
                                    size: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    "SHS " + widget.tripTicket.total.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 15,
                                          color: Colors.white,
                                        )),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    widget
                                        .tripTicket.trip!.departureLocationName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 15,
                                          color: Colors.white,
                                        )),
                                const SizedBox(
                                  width: 5,
                                ),
                                const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Icon(
                                    Icons.arrow_right_alt,
                                    color: Colors.white70,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    widget.tripTicket.trip!.arrivalLocationName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ))
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.cyan,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    widget
                                        .tripTicket.buyerNames,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                      fontSize: 15,
                                      color: Colors.white,
                                    )),
                                const SizedBox(
                                  width: 5,
                                ),
                                const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Icon(
                                    Icons.arrow_right_alt,
                                    color: Colors.white70,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    widget.tripTicket.buyerPhoneNumber,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(widget.tripTicket.trip!.tripNumber,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 14,
                                          color: Colors.yellow,
                                        )),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(widget.tripTicket.trip!.busPlateNo,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 12,
                                          color: Colors.white70,
                                        )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(widget.tripTicket.createdAt.toDate().toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                      fontSize: 14,
                                      color: Colors.blue[900],
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.red[900],
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.tripTicket.status == "pending"
                              ? Icon(
                                  Icons.chair,
                                  color: Colors.white70,
                                  size: 30,
                                )
                              : Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.white70,
                                  size: 30,
                                ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.tripTicket.seatNumber,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 17, color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  void _openBottomSheet(
      {
      // required AdminUserModel user,
      required BusCompany company,
      required TripTicket tripTicket,
      required String tripPrice,
      required String companyName}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return _getTicketOptions();
        });
  }

  Widget _getTicketOptions() {
    final options = [
      "Assign Seat Number",
      "Use Ticket Now",
      // "Re-Assign Ticket",
      "Cancel Ticket"
    ];
    return Container(
      height: 200,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: options
            .map((option) => ListTile(
                  onTap: () async {
                    if (option == "Assign Seat Number") {
                      Navigator.of(context).pop();
                      _assignSeatNumber(widget.tripTicket);
                    }
                    if (option == "Use Ticket Now") {
                      Navigator.of(context).pop();
                      setState(() {
                        isUpdating = true;
                      });
                      bool result = await updateTicketUsed(
                          ticketId: widget.tripTicket.ticketId,
                          ticketNo: widget.tripTicket.ticketNumber,
                          clientId: widget.tripTicket.userId,
                          companyId: widget.company.uid);
                      if (result == true) {
                        setState(() {
                          widget.tripTicket.status == "used";
                          isUpdating = false;
                        });
                      } else {
                        setState(() {
                          isUpdating = false;
                        });
                      }
                    }
                    if (option == "Cancel Ticket") {
                      Navigator.of(context).pop();
                      setState(() {
                        isUpdating = true;
                      });
                      bool result = await updateTicketCancelled(
                          ticketId: widget.tripTicket.ticketId);
                      if (result == true) {
                        setState(() {
                          isUpdating = false;
                        });
                      } else {
                        setState(() {
                          isUpdating = false;
                        });
                      }
                    }
                    // if (option == "Re-Assign Ticket") {
                    //   Navigator.of(context).pop();
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => TicketReAssign(
                    //                 user: widget.user,
                    //                 tripTicket: widget.tripTicket,
                    //               )));
                    // }
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

  Future<void> _assignSeatNumber(TripTicket ticket) {
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
                  "Assign Seat Number To Ticket?",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                          height: 50,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Enter Number Here",
                              border: OutlineInputBorder()
                            ),
                          ),
                        )),
                  ],
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
                  style: TextStyle(color: Colors.red[900]),
                )),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
                onTap: () async {
                  try {
                    if(_ctr.text.trim().isEmpty) {
                      Get.snackbar("Failed!", "Please Provide A value",
                          backgroundColor: Colors.red);
                      return;
                    }
                    if(isSubmitting) {
                      return;
                    }
                    setState(() {
                      isSubmitting = true;
                    });
                    var res = await assignTicketSeatNumber(ticketId: ticket.ticketId, seatNumber: _ctr.text);
                    setState(() {
                      isSubmitting = false;
                    });
                    if(res.status == true) {
                      Get.snackbar("Great!", res.message,
                          backgroundColor: Colors.green);
                      Get.back();
                    }else{
                      Get.snackbar("Failed!", res.message,
                          backgroundColor: Colors.red);
                    }
                  }catch (e){
                    setState(() {
                      isSubmitting = false;
                    });
                    Get.snackbar("Failed!", "Something Went wrong!",
                        backgroundColor: Colors.red);
                    Get.back();
                  }
                },
                child: Container(
                  height: 30,
                  width: 100,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue[900]!),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    isSubmitting ? " ... " : "SUBMIT",
                    style: TextStyle(color: Colors.blue[900]),
                  ),
                ))
          ],
        );
      },
    );
  }

}
