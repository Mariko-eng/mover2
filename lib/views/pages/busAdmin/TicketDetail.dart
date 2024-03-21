import 'package:bus_stop_develop_admin/models/ticket.dart';
import 'package:bus_stop_develop_admin/models/user/user.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../shared/utils.dart';

class TicketDetails extends StatefulWidget {
  final AdminUserModel user;
  final TripTicket tripTicket;
  final String tripPrice;
  final String companyName;

  const TicketDetails(
      {Key? key,
      required this.user,
      required this.tripTicket,
      required this.tripPrice,
      required this.companyName})
      : super(key: key);

  @override
  _TicketDetailsState createState() => _TicketDetailsState();
}

class _TicketDetailsState extends State<TicketDetails> {
  final globalKey = GlobalKey();
  bool isDownloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
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
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                  width: 300,
                  height: 420,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20))),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  widget.tripTicket.ticketNumber.toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                decoration: const BoxDecoration(
                                    color: Color(0xffE4181D),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20))),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(dateToTime(widget
                                          .tripTicket.trip!.departureTime)),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Text(widget
                                            .tripTicket.departureLocation),
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
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 1),
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
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 2),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text("Company Name"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 2),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(widget.companyName),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Text("Ticket Price"),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 3,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          height: 40,
                                          width: 80,
                                          alignment: Alignment.center,
                                          child: Text(
                                            widget.tripTicket.trip!.price
                                                .toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          decoration: BoxDecoration(
                                              color: Color(0xffED696C),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(right: 20),
                                        child: Text("No Of The Tickets"),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 3,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          height: 40,
                                          width: 80,
                                          alignment: Alignment.center,
                                          child: Text(
                                            widget.tripTicket.numberOfTickets
                                                .toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          decoration: BoxDecoration(
                                              color: Color(0xffED696C),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Text("Total"),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 3,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          height: 40,
                                          width: 80,
                                          alignment: Alignment.center,
                                          child: Text(
                                            widget.tripTicket.total.toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          decoration: BoxDecoration(
                                              color: Color(0xffED696C),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50))),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50))),
                        ),
                      )
                    ],
                  )),
              Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    DottedLine(),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(50))),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50))),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            isDownloading
                                ? Container(
                                    child: CircularProgressIndicator(
                                      color: Colors.red,
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () async {
                                      // setState(() {
                                      //   isDownloading = true;
                                      // });
                                      // await _captureAndSavePng(
                                      //     widget.tripTicket.trip!.id);
                                      // setState(() {
                                      //   isDownloading = false;
                                      // });
                                    },
                                    child: Icon(
                                      Icons.download_outlined,
                                      color: Colors.red[900],
                                      size: 40,
                                    ),
                                  ),
                            Container(
                              width: 100,
                              height: 100,
                              child: RepaintBoundary(
                                key: globalKey,
                                child: Container(),
                                // child: QrImage(
                                //   data: "Bus Company: " +
                                //       widget.companyName +
                                //       ", " +
                                //       "Trip Price: " +
                                //       widget.tripPrice +
                                //       ", " +
                                //       "Tickets: " +
                                //       widget.tripTicket.numberOfTickets
                                //           .toString() +
                                //       ", " +
                                //       "Amount Paid: " +
                                //       widget.tripTicket.amountPaid.toString() +
                                //       ", Date Of Payment: " +
                                //       widget.tripTicket.createdAt
                                //           .toDate()
                                //           .toString(),
                                //   version: QrVersions.auto,
                                //   size: 100.0,
                                // ),
                              ),
                            ),
                            Icon(
                              Icons.directions_bus,
                              color: Colors.red[900],
                              size: 40,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> _captureAndSavePng(String ticketId) async {
  //   try {
  //     RenderRepaintBoundary boundary =
  //         globalKey.currentContext.findRenderObject();
  //     var image = await boundary.toImage();
  //     ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
  //     Uint8List pngBytes = byteData.buffer.asUint8List();
  //     Directory appDocDir = await getApplicationDocumentsDirectory();
  //     String appDocPath = appDocDir.path;
  //     final file = File('$appDocPath/' + DateTime.now().toString() + ".png");
  //     await file.writeAsBytes(pngBytes);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}
