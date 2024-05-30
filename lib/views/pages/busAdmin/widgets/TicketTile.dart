import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/ticket.dart';
import 'package:bus_stop_develop_admin/views/shared/utils.dart';

class BusAdminTicketTileWidget extends StatefulWidget {
  final BusCompany company;
  final TripTicket tripTicket;

  const BusAdminTicketTileWidget({
    Key? key,
    required this.company,
    required this.tripTicket,
  }) : super(key: key);

  @override
  _BusAdminTicketTileState createState() => _BusAdminTicketTileState();
}

class _BusAdminTicketTileState extends State<BusAdminTicketTileWidget> {
  final TextEditingController _ctr = TextEditingController();
  bool isSubmitting = false;

  @override
  void dispose() {
    _ctr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            borderRadius: BorderRadius.circular(10),
          ),
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
                                  fontWeight: FontWeight.bold,
                                ),
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
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: Colors.red[900],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.tripTicket.status.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            dateToStringNew(
                                widget.tripTicket.trip!.departureTime),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.monetization_on,
                            color: Colors.blue[900],
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "SHS ${widget.tripTicket.total}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.green,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.tripTicket.trip!.departureLocationName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.arrow_right_alt,
                            color: Colors.white70,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.tripTicket.trip!.arrivalLocationName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.cyan,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.tripTicket.buyerNames,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.arrow_right_alt,
                            color: Colors.white70,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.tripTicket.buyerPhoneNumber,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.tripTicket.trip!.tripNumber,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 14,
                                  color: Colors.yellow,
                                ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.tripTicket.trip!.busPlateNo,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.tripTicket.createdAt.toDate().toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 14,
                                  color: Colors.blue[900],
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
              Container(
                width: 100,
                decoration: BoxDecoration(
                  color: widget.tripTicket.status == "used"
                      ? Colors.indigo
                      : widget.tripTicket.status == "cancelled"
                          ? Colors.black
                          : Colors.red[900],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.tripTicket.status == "pending"
                        ? const Icon(
                            Icons.chair,
                            color: Colors.white70,
                            size: 30,
                          )
                        : widget.tripTicket.status == "cancelled"
                            ? const Icon(
                                Icons.cancel,
                                color: Colors.white70,
                                size: 30,
                              )
                            : const Icon(
                                Icons.check_circle_outline,
                                color: Colors.white70,
                                size: 30,
                              ),
                    const SizedBox(height: 5),
                    Text(
                      widget.tripTicket.seatNumber,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 17, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openBottomSheet({
    required BusCompany company,
    required TripTicket tripTicket,
    required String tripPrice,
    required String companyName,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return _getTicketOptions(context);
      },
    );
  }

  Widget _getTicketOptions(BuildContext context) {
    var options = [
      "Assign Seat Number",
      "Use Ticket Now",
      // "Re-Assign Ticket",
      "Cancel Ticket"
    ];
    if (widget.tripTicket.status == "cancelled") {
      options = [
        "Reset Ticket"
      ];
    }
    return Container(
      height: 200,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: ListView(
        children: options
            .map(
              (option) => ListTile(
                onTap: () async {
                  if (option == "Assign Seat Number") {
                    Navigator.of(context).pop();
                    _assignSeatNumber(context, widget.tripTicket);
                  }
                  if (option == "Use Ticket Now") {
                    Navigator.of(context).pop();
                    _confirmTickedUsed(context, widget.tripTicket);
                  }
                  if (option == "Cancel Ticket") {
                    Navigator.of(context).pop();
                    _confirmTickedCancelled(context, widget.tripTicket);
                  }

                  if (option == "Reset Ticket") {
                    Navigator.of(context).pop();
                    _confirmTicketReset(context, widget.tripTicket);
                  }
                },
                title: Column(
                  children: [
                    Text(
                      option,
                      textAlign: TextAlign.start,
                      style: const TextStyle(color: Color(0xFFE4191D)),
                    ),
                    const SizedBox(height: 4),
                    const Divider(height: 1),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Future<void> _confirmTickedUsed(BuildContext context, TripTicket ticket) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Container(
                margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                width: double.infinity,
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Ticket Confirmation?",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Do You Want to Continue?",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.tripTicket.ticketNumber,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.red[900],
                          fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 10),
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
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () async {
                    try {
                      if (isSubmitting) {
                        return;
                      }
                      setState(() {
                        isSubmitting = true;
                      });
                      bool result = await updateTicketUsed(
                        ticketId: widget.tripTicket.ticketId,
                        ticketNo: widget.tripTicket.ticketNumber,
                        clientId: widget.tripTicket.userId,
                        companyId: widget.company.uid,
                      );

                      if (result == true) {
                        setState(() {
                          isSubmitting = false;
                        });
                        Get.back();
                        Get.snackbar("Great!", "Ticket Confirmed!",
                            backgroundColor: Colors.green);
                      } else {
                        setState(() {
                          isSubmitting = false;
                        });
                        Get.snackbar("Failed!", "Something Went wrong!",
                            backgroundColor: Colors.red);
                      }
                    } catch (e) {
                      setState(() {
                        isSubmitting = false;
                      });
                      Get.back();
                      Get.snackbar("Failed!", "Something Went wrong!",
                          backgroundColor: Colors.red);
                    }
                  },
                  child: Container(
                    height: 30,
                    width: 100,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue[900]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      isSubmitting ? " ... " : "SUBMIT",
                      style: TextStyle(color: Colors.blue[900]),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _confirmTickedCancelled(
      BuildContext context, TripTicket ticket) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Container(
                margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                width: double.infinity,
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Ticket Cancellation?",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Do You Want to Continue?",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.tripTicket.ticketNumber,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.red[900],
                          fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 10),
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
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () async {
                    try {
                      if (isSubmitting) {
                        return;
                      }
                      setState(() {
                        isSubmitting = true;
                      });
                      bool result = await updateTicketCancelled(
                        ticketId: widget.tripTicket.ticketId,
                      );

                      if (result == true) {
                        setState(() {
                          isSubmitting = false;
                        });
                        Get.back();
                        Get.snackbar("Great!", "Ticket Cancelled!",
                            backgroundColor: Colors.green);
                      } else {
                        setState(() {
                          isSubmitting = false;
                        });
                        Get.snackbar("Failed!", "Something Went wrong!",
                            backgroundColor: Colors.red);
                      }
                    } catch (e) {
                      setState(() {
                        isSubmitting = false;
                      });
                      Get.back();
                      Get.snackbar("Failed!", "Something Went wrong!",
                          backgroundColor: Colors.red);
                    }
                  },
                  child: Container(
                    height: 30,
                    width: 100,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue[900]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      isSubmitting ? " ... " : "SUBMIT",
                      style: TextStyle(color: Colors.blue[900]),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _confirmTicketReset(
      BuildContext context, TripTicket ticket) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Container(
                margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                width: double.infinity,
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Ticket Reset?",
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Do You Want to Continue?",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.tripTicket.ticketNumber,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.red[900],
                          fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 10),
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
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () async {
                    try {
                      if (isSubmitting) {
                        return;
                      }
                      setState(() {
                        isSubmitting = true;
                      });
                      bool result = await updateTicketPending(
                        ticketId: widget.tripTicket.ticketId,
                      );

                      if (result == true) {
                        setState(() {
                          isSubmitting = false;
                        });
                        Get.back();
                        Get.snackbar("Great!", "Ticket Reset!",
                            backgroundColor: Colors.green);
                      } else {
                        setState(() {
                          isSubmitting = false;
                        });
                        Get.snackbar("Failed!", "Something Went wrong!",
                            backgroundColor: Colors.red);
                      }
                    } catch (e) {
                      setState(() {
                        isSubmitting = false;
                      });
                      Get.back();
                      Get.snackbar("Failed!", "Something Went wrong!",
                          backgroundColor: Colors.red);
                    }
                  },
                  child: Container(
                    height: 30,
                    width: 100,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue[900]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      isSubmitting ? " ... " : "SUBMIT",
                      style: TextStyle(color: Colors.blue[900]),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _assignSeatNumber(BuildContext context, TripTicket ticket) {
    // Create the TextEditingController outside the dialog builder
    final TextEditingController _localCtr = TextEditingController();

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Container(
                margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                width: double.infinity,
                height: 140,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Assign Seat Number To Ticket?",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.tripTicket.ticketNumber,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.red[900],
                          fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            child: TextField(
                              controller: _localCtr,
                              minLines: 1,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                hintText: "Enter Number Here",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
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
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () async {
                    try {
                      if (_localCtr.text.trim().isEmpty) {
                        Get.snackbar("Failed!", "Please Provide A value",
                            backgroundColor: Colors.red);
                        return;
                      }
                      if (isSubmitting) {
                        return;
                      }
                      setState(() {
                        isSubmitting = true;
                      });
                      var res = await assignTicketSeatNumber(
                        ticketId: ticket.ticketId,
                        seatNumber: _localCtr.text,
                      );

                      if (res.status == true) {
                        setState(() {
                          isSubmitting = false;
                        });
                        Get.back();
                        Get.snackbar("Great!", res.message,
                            backgroundColor: Colors.green);
                      } else {
                        setState(() {
                          isSubmitting = false;
                        });
                        Get.snackbar("Failed!", res.message,
                            backgroundColor: Colors.red);
                      }
                    } catch (e) {
                      setState(() {
                        isSubmitting = false;
                      });
                      Get.back();
                      Get.snackbar("Failed!", "Something Went wrong!",
                          backgroundColor: Colors.red);
                    }
                  },
                  child: Container(
                    height: 30,
                    width: 100,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue[900]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      isSubmitting ? " ... " : "SUBMIT",
                      style: TextStyle(color: Colors.blue[900]),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

// class BusAdminTicketTileWidget extends StatefulWidget {
//   final BusCompany company;
//   final TripTicket tripTicket;
//
//   const BusAdminTicketTileWidget(
//       {Key? key,
//       required this.company,
//       required this.tripTicket})
//       : super(key: key);
//
//   @override
//   _BusAdminTicketTileState createState() => _BusAdminTicketTileState();
// }
//
// class _BusAdminTicketTileState extends State<BusAdminTicketTileWidget> {
//   bool isUpdating = false;
//   final GlobalKey _dialogKey = GlobalKey();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return isUpdating
//         ? const SizedBox(
//             width: 300,
//             height: 310,
//             child: Center(
//               child: LoadingWidget(),
//             ),
//           )
//         : GestureDetector(
//             onTap: () {
//               if (widget.tripTicket.status != "used") {
//                 // _openBottomSheet(
//                 //   company: widget.company,
//                 //   tripTicket: widget.tripTicket,
//                 //   companyName: widget.company.name,
//                 //   tripPrice: widget.tripTicket.trip!.price.toString(),
//                 // );
//
//                 _assignSeatNumber(context, widget.tripTicket,);
//               }
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 height: 220,
//                 decoration: BoxDecoration(
//                     color: Colors.red[400],
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 20, top: 10),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   widget.tripTicket.ticketType,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodyMedium!
//                                       .copyWith(
//                                           fontSize: 17,
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(right: 10),
//                                   child: Text(
//                                     widget.tripTicket.ticketNumber,
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyMedium!
//                                         .copyWith(
//                                             fontSize: 17,
//                                             color: Colors.yellow[100],
//                                             fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   height: 20,
//                                   width: 20,
//                                   decoration: BoxDecoration(
//                                       color: Colors.red[900],
//                                       borderRadius: BorderRadius.circular(10)),
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Text(
//                                   widget.tripTicket.status.toUpperCase(),
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodyMedium!
//                                       .copyWith(
//                                           fontSize: 15, color: Colors.white),
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Row(
//                               children: [
//                                 Container(
//                                   height: 20,
//                                   width: 20,
//                                   child: Icon(
//                                     Icons.calendar_today,
//                                     color: Colors.yellow,
//                                     size: 20,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Text(
//                                     dateToStringNew(
//                                         widget.tripTicket.trip!.departureTime),
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyMedium!
//                                         .copyWith(
//                                           fontSize: 15,
//                                           color: Colors.white,
//                                         ))
//                               ],
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Row(
//                               children: [
//                                 Container(
//                                   height: 20,
//                                   width: 20,
//                                   child: Icon(
//                                     Icons.monetization_on,
//                                     color: Colors.blue[900],
//                                     size: 20,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Text(
//                                     "SHS " + widget.tripTicket.total.toString(),
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyMedium!
//                                         .copyWith(
//                                           fontSize: 15,
//                                           color: Colors.white,
//                                         )),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Container(
//                                   height: 20,
//                                   width: 20,
//                                   child: Icon(
//                                     Icons.location_on,
//                                     color: Colors.green,
//                                     size: 20,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Text(
//                                     widget
//                                         .tripTicket.trip!.departureLocationName,
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyMedium!
//                                         .copyWith(
//                                           fontSize: 15,
//                                           color: Colors.white,
//                                         )),
//                                 const SizedBox(
//                                   width: 5,
//                                 ),
//                                 const SizedBox(
//                                   height: 20,
//                                   width: 20,
//                                   child: Icon(
//                                     Icons.arrow_right_alt,
//                                     color: Colors.white70,
//                                     size: 20,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 5,
//                                 ),
//                                 Text(
//                                     widget.tripTicket.trip!.arrivalLocationName,
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyMedium!
//                                         .copyWith(
//                                           fontSize: 15,
//                                           color: Colors.white,
//                                         ))
//                               ],
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Row(
//                               children: [
//                                 Container(
//                                   height: 20,
//                                   width: 20,
//                                   child: Icon(
//                                     Icons.person,
//                                     color: Colors.cyan,
//                                     size: 20,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Text(
//                                     widget
//                                         .tripTicket.buyerNames,
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyMedium!
//                                         .copyWith(
//                                       fontSize: 15,
//                                       color: Colors.white,
//                                     )),
//                                 const SizedBox(
//                                   width: 5,
//                                 ),
//                                 const SizedBox(
//                                   height: 20,
//                                   width: 20,
//                                   child: Icon(
//                                     Icons.arrow_right_alt,
//                                     color: Colors.white70,
//                                     size: 20,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 5,
//                                 ),
//                                 Text(
//                                     widget.tripTicket.buyerPhoneNumber,
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyMedium!
//                                         .copyWith(
//                                       fontSize: 15,
//                                       color: Colors.white,
//                                     ))
//                               ],
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text(widget.tripTicket.trip!.tripNumber,
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyMedium!
//                                         .copyWith(
//                                           fontSize: 14,
//                                           color: Colors.yellow,
//                                         )),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Text(widget.tripTicket.trip!.busPlateNo,
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyMedium!
//                                         .copyWith(
//                                           fontSize: 12,
//                                           color: Colors.white70,
//                                         )),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text(widget.tripTicket.createdAt.toDate().toString(),
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyMedium!
//                                         .copyWith(
//                                       fontSize: 14,
//                                       color: Colors.blue[900],
//                                     )),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: 100,
//                       decoration: BoxDecoration(
//                           color: Colors.red[900],
//                           borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(10),
//                               bottomRight: Radius.circular(10))),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           widget.tripTicket.status == "pending"
//                               ? Icon(
//                                   Icons.chair,
//                                   color: Colors.white70,
//                                   size: 30,
//                                 )
//                               : Icon(
//                                   Icons.check_circle_outline,
//                                   color: Colors.white70,
//                                   size: 30,
//                                 ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Text(
//                             widget.tripTicket.seatNumber,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyMedium!
//                                 .copyWith(fontSize: 17, color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//   }
//
//   void _openBottomSheet(
//       {
//       required BusCompany company,
//       required TripTicket tripTicket,
//       required String tripPrice,
//       required String companyName}) {
//     showModalBottomSheet(
//         context: context,
//         builder: (context) {
//           return _getTicketOptions(context);
//         });
//   }
//
//   Widget _getTicketOptions(BuildContext context) {
//     final options = [
//       "Assign Seat Number",
//       "Use Ticket Now",
//       // "Re-Assign Ticket",
//       "Cancel Ticket"
//     ];
//     return Container(
//       height: 200,
//       margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
//       color: Colors.white,
//       child: ListView(
//         children: options
//             .map((option) => ListTile(
//                   onTap: () async {
//                     if (option == "Assign Seat Number") {
//                       Navigator.of(context).pop();
//                       _assignSeatNumber(context,widget.tripTicket);
//                     }
//                     if (option == "Use Ticket Now") {
//                       Navigator.of(context).pop();
//                       setState(() {
//                         isUpdating = true;
//                       });
//                       bool result = await updateTicketUsed(
//                           ticketId: widget.tripTicket.ticketId,
//                           ticketNo: widget.tripTicket.ticketNumber,
//                           clientId: widget.tripTicket.userId,
//                           companyId: widget.company.uid);
//                       if (result == true) {
//                         setState(() {
//                           isUpdating = false;
//                         });
//                       } else {
//                         setState(() {
//                           isUpdating = false;
//                         });
//                       }
//                     }
//                     if (option == "Cancel Ticket") {
//                       Navigator.of(context).pop();
//                       setState(() {
//                         isUpdating = true;
//                       });
//                       bool result = await updateTicketCancelled(
//                           ticketId: widget.tripTicket.ticketId);
//                       if (result == true) {
//                         setState(() {
//                           isUpdating = false;
//                         });
//                       } else {
//                         setState(() {
//                           isUpdating = false;
//                         });
//                       }
//                     }
//                     // if (option == "Re-Assign Ticket") {
//                     //   Navigator.of(context).pop();
//                     //   Navigator.push(
//                     //       context,
//                     //       MaterialPageRoute(
//                     //           builder: (context) => TicketReAssign(
//                     //                 user: widget.user,
//                     //                 tripTicket: widget.tripTicket,
//                     //               )));
//                     // }
//                   },
//                   title: Column(
//                     children: [
//                       Text(
//                         option,
//                         textAlign: TextAlign.start,
//                         style: TextStyle(color: Color(0xFFE4191D)),
//                       ),
//                       SizedBox(height: 4),
//                       Divider(height: 1)
//                     ],
//                   ),
//                 ))
//             .toList(),
//       ),
//     );
//   }
//
//   Future<void> _assignSeatNumber(BuildContext context,TripTicket ticket) {
//     // Create the TextEditingController outside the dialog builder
//     TextEditingController _ctr = TextEditingController();
//
//     return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         bool isSubmitting = false;
//
//         return StatefulBuilder(
//           key: _dialogKey,
//           builder: (context, setState) {
//             return AlertDialog(
//               content: Container(
//                 margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
//                 width: double.infinity,
//                 height: 80,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Assign Seat Number To Ticket?",
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             height: 50,
//                             child: TextField(
//                               controller: _ctr,
//                               decoration: InputDecoration(
//                                 hintText: "Enter Number Here",
//                                 border: OutlineInputBorder(),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               actions: [
//                 GestureDetector(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: Text(
//                     "CANCEL",
//                     style: TextStyle(color: Colors.red[900]),
//                   ),
//                 ),
//                 const SizedBox(width: 5),
//                 GestureDetector(
//                   onTap: () async {
//                     try {
//                       if (_ctr.text.trim().isEmpty) {
//                         Get.snackbar("Failed!", "Please Provide A value",
//                             backgroundColor: Colors.red);
//                         return;
//                       }
//                       if (isSubmitting) {
//                         return;
//                       }
//                       setState(() {
//                         isSubmitting = true;
//                       });
//                       var res = await assignTicketSeatNumber(
//                           ticketId: ticket.ticketId,
//                           seatNumber: _ctr.text);
//
//                       if (res.status == true) {
//                         setState(() {
//                           isSubmitting = false;
//                           Get.back();
//                           Get.snackbar("Great!", res.message,
//                               backgroundColor: Colors.green);
//                         });
//                       } else {
//                         setState(() {
//                           isSubmitting = false;
//                           Get.snackbar("Failed!", res.message,
//                               backgroundColor: Colors.red);
//                         });
//                       }
//                     } catch (e) {
//                       setState(() {
//                         isSubmitting = false;
//                         Get.back();
//                         Get.snackbar("Failed!", "Something Went wrong!",
//                             backgroundColor: Colors.red);
//                       });
//                     }
//                   },
//                   child: Container(
//                     height: 30,
//                     width: 100,
//                     alignment: Alignment.center,
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     decoration: BoxDecoration(
//                         border: Border.all(color: Colors.blue[900]!),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Text(
//                       isSubmitting ? " ... " : "SUBMIT",
//                       style: TextStyle(color: Colors.blue[900]),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }
