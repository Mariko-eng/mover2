import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/ticket.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/TicketTile.dart';
import 'package:bus_stop_develop_admin/views/shared/loading.dart';
import 'package:bus_stop_develop_admin/controllers/authProvider.dart';

class TicketScanVerify extends StatefulWidget {
  final BusCompany company;

  const TicketScanVerify({Key? key, required this.company}) : super(key: key);

  @override
  _TicketScanVerifyState createState() => _TicketScanVerifyState();
}

class _TicketScanVerifyState extends State<TicketScanVerify> {
  final qrKey = GlobalKey(debugLabel: "QR");
  QRViewController? controller;
  Barcode? barcodeResult;

  TripTicket? tripTicket;
  bool isLoadingTicket = false;

  String _ticketError = "";

  @override
  void dispose() {
    if (controller != null) {
      controller!.dispose();
    }
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) {
      setState(() => barcodeResult = scanData);
    });
  }

  @override
  void reassemble() {
    if (controller != null) {
      super.reassemble();
      if (Platform.isAndroid) {
        controller!.pauseCamera();
      } else if (Platform.isIOS) {
        controller!.resumeCamera();
      }
    }
  }

  void _readQr() async {
    if (barcodeResult != null) {
      controller!.pauseCamera();
      controller!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    _readQr();

    return Scaffold(
      backgroundColor: Color(0xfffdfdfd),
      appBar: AppBar(
        backgroundColor: Color(0xfffdfdfd),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Scan Tickets",
          style: TextStyle(color: Color(0xffE4181D)),
        ),
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
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Color(0xff62020a),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                  child: const Text(
                    "Scan Ticket",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            barcodeResult == null
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: buildQrView(context),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            try {
                              setState(() {
                                barcodeResult = null;
                                tripTicket = null;
                                _ticketError = "";
                              });
                            } catch (e) {
                              print(e.toString());
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera,
                                  size: 50,
                                  color: Color(0xffE4181D),
                                ),
                                Text(
                                  "Scan Again",
                                  style: TextStyle(
                                      fontSize: 20, color: Color(0xffE4181D)),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: Text(barcodeResult!.code!),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xffE4181D)),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            _ticketError != "" || tripTicket != null
                                ? Container()
                                : GestureDetector(
                                    onTap: () async {
                                      if (_ticketError != "") {
                                        setState(() {
                                          // isScanning = false;
                                          barcodeResult = null;
                                          // _ticketData = null;
                                          // _ticketError = "";
                                        });
                                        return;
                                      }
                                      if (barcodeResult != null) {
                                        setState(() {
                                          isLoadingTicket = true;
                                        });
                                        TripTicket? res =
                                            await searchTicketByNumber(
                                                ticketNumber:
                                                    barcodeResult!.code!);
                                        if (res == null) {
                                          setState(() {
                                            isLoadingTicket = false;
                                            _ticketError = "Ticket Not Found";
                                          });
                                        } else {
                                          setState(() {
                                            tripTicket = res;
                                            isLoadingTicket = false;
                                            _ticketError = "";
                                          });
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffE4181D),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "Search",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        isLoadingTicket
                            ? Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                child: const Loading())
                            : Container(),
                        _ticketError != ""
                            ? Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration:
                                    BoxDecoration(color: Colors.red[800]),
                                child: const Text(
                                  "INVALID",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ))
                            : Container(),
                        _ticketError != ""
                            ? Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: "Ticket Not Found For This Event!",
                                      style: const TextStyle(
                                          color: Color(0xff62020a)),
                                      children: [
                                        TextSpan(
                                          text: "\n OR",
                                          style: TextStyle(
                                              color: Colors.blue[900]),
                                        ),
                                        const TextSpan(
                                          text: "\n Ticket Is Already Used!",
                                          style: TextStyle(
                                              color: Color(0xff12010a)),
                                        ),
                                      ]),
                                ))
                            : Container(),
                        tripTicket == null
                            ? Container()
                            : FutureBuilder(
                                future: tripTicket!.setTripData(context),
                                // ignore: missing_return
                                builder: (context, snapshot) {
                                  TripTicket? ticket = snapshot.data;
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return const Loading();
                                      return Container();
                                    case ConnectionState.none:
                                      return const Text(
                                        'No Ticket',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFFE4191D),
                                            fontSize: 20.0),
                                      );
                                    case ConnectionState.active:
                                      return const Text('Searching... ');
                                    case ConnectionState.done:
                                      return ticket == null
                                          ? Container()
                                          : TicketTile(
                                              company: userProvider.busCompany!,
                                              tripTicket: ticket);
                                  }
                                },
                              )
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderColor: Colors.red,
            borderRadius: 10,
            borderLength: 20,
            borderWidth: 10,
            cutOutSize: MediaQuery.of(context).size.width * 0.8),
      );
}
