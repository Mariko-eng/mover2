import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/destination/destination.dart';
import 'package:bus_stop_develop_admin/models/trip.dart';
import 'package:bus_stop_develop_admin/models/user/user.dart';
import 'package:bus_stop_develop_admin/views/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TripsViewEdit extends StatefulWidget {
  // final AdminUserModel user;
  final BusCompany company;
  final Trip trip;

  const TripsViewEdit({Key? key, required this.company, required this.trip}) : super(key: key);

  @override
  _TripsViewEditState createState() => _TripsViewEditState();
}

class _TripsViewEditState extends State<TripsViewEdit> {
  final _arrivalController = TextEditingController();
  final _arrivalIdController = TextEditingController();
  final _departureController = TextEditingController();
  final _departureIdController = TextEditingController();
  final _priceController = TextEditingController();
  final _totalSeatsController = TextEditingController();
  final _departureTimeController = TextEditingController();
  final _arrivalTimeController = TextEditingController();

  final _totalSeatsVipController = TextEditingController();
  final _priceVipController = TextEditingController();

  late DateTime departureTime;
  late DateTime arrivalTime;

  int seats = 0;
  int price = 0;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _arrivalController.text = widget.trip.arrivalLocationName;
      _arrivalIdController.text = widget.trip.arrivalLocationId;
      _departureController.text = widget.trip.departureLocationName;
      _departureIdController.text = widget.trip.departureLocationId;
      _departureTimeController.text =
          DateFormat('dd-MMM-yyyy - HH:mm').format(widget.trip.
          departureTime);
      _arrivalTimeController.text =
          DateFormat('dd-MMM-yyyy - HH:mm').format(widget.trip.arrivalTime);
      departureTime = widget.trip.departureTime;
      arrivalTime = widget.trip.arrivalTime;
      _totalSeatsController.text = widget.trip.totalOrdinarySeats.toString();
      _priceController.text = widget.trip.priceOrdinary.toString();
      _totalSeatsVipController.text = widget.trip.totalVipSeats.toString();
      _priceVipController.text = widget.trip.priceVip.toString();
      seats = widget.trip.totalSeats;
      price = widget.trip.priceOrdinary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Loading(),
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.grey[200],
              iconTheme: IconThemeData(color: Color(0xff62020a)),
              title: widget.trip.tripType == "VIP"
                  ? Text(
                      "Edit Trip (VIP)",
                      style: TextStyle(color: Color(0xff62020a)),
                    )
                  : Text(
                      "Edit Trip (Ordinary)",
                      style: TextStyle(color: Color(0xff62020a)),
                    ),
            ),
            body: FutureBuilder(
              future: getDestinations(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                if (snapshot.hasData) {
                  List<Destination> destinations = snapshot.data;
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFieldContainer(
                            child: TextField(
                              controller: _departureController,
                              readOnly: true,
                              style: const TextStyle(fontSize: 20),
                              cursorColor: Colors.red,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.location_history_sharp,
                                  color: Color(0xff62020a),
                                ),
                                hintText: "Source",
                                border: InputBorder.none,
                              ),
                              onTap: () {
                                showDestinations(context, destinations, true);
                              },
                            ),
                          ),
                          TextFieldContainer(
                            child: TextField(
                              controller: _arrivalController,
                              readOnly: true,
                              style: const TextStyle(fontSize: 20),
                              cursorColor: Colors.red,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.location_history,
                                  color: Color(0xff62020a),
                                ),
                                hintText: "Destination",
                                border: InputBorder.none,
                              ),
                              onTap: () {
                                showDestinations(context, destinations, false);
                              },
                            ),
                          ),
                          TextFieldContainer(
                            child: TextField(
                              controller: _departureTimeController,
                              readOnly: true,
                              style: const TextStyle(fontSize: 20),
                              cursorColor: Colors.red,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.calendar_today,
                                  color: Color(0xff62020a),
                                ),
                                hintText: "Departure Time",
                                border: InputBorder.none,
                              ),
                              onTap: () {
                                dateTimePickerWidget(context, true);
                              },
                            ),
                          ),
                          TextFieldContainer(
                            child: TextField(
                              controller: _arrivalTimeController,
                              readOnly: true,
                              style: const TextStyle(fontSize: 20),
                              cursorColor: Colors.red,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.today_rounded,
                                  color: Color(0xff62020a),
                                ),
                                hintText: "Arrival Time",
                                border: InputBorder.none,
                              ),
                              onTap: () {
                                dateTimePickerWidget(context, false);
                              },
                            ),
                          ),
                          TextFieldContainer(
                            child: TextField(
                              controller: _totalSeatsController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(fontSize: 20),
                              cursorColor: Colors.red,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.people_outline,
                                  color: Color(0xff62020a),
                                ),
                                labelText: "Total Seats",
                                labelStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff62020a)
                                ),
                                hintText: "Total Seats",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          TextFieldContainer(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: _priceController,
                              style: const TextStyle(fontSize: 20),
                              cursorColor: Colors.red,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.money_off,
                                  color: Color(0xff62020a),
                                ),
                                labelText: "Price",
                                labelStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff62020a)
                                ),
                                hintText: "Price",
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          widget.trip.tripType != "Ordinary" ?
                          TextFieldContainer(
                            child: TextField(
                              controller: _totalSeatsVipController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(fontSize: 20),
                              cursorColor: Colors.red,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.people_outline,
                                  color: Color(0xff62020a),
                                ),
                                labelText: "Total VIP Seats",
                                labelStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff62020a)
                                ),
                                hintText: "Total VIP Seats",
                                border: InputBorder.none,
                              ),
                            ),
                          )
                              :Container(),

                          widget.trip.tripType != "Ordinary" ?
                          TextFieldContainer(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: _priceVipController,
                              style: const TextStyle(fontSize: 20),
                              cursorColor: Colors.red,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.money_off,
                                  color: Color(0xff62020a),
                                ),
                                labelText: "VIP Price",
                                labelStyle: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff62020a)
                                ),
                                hintText: "VIP Price",
                                border: InputBorder.none,
                              ),
                            ),
                          )
                              :Container(),

                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //       horizontal: 30, vertical: 10),
                          //   child: GestureDetector(
                          //     onDoubleTap: () async {
                          //       if (_departureIdController.text.isEmpty) {
                          //          Get.snackbar("Failed",
                          //             "Select Source/ Departure Location",
                          //             backgroundColor: Colors.purpleAccent);
                          //       } else if (_arrivalIdController.text.isEmpty) {
                          //          Get.snackbar(
                          //             "Failed", "Select Destination Location",
                          //             backgroundColor: Colors.purpleAccent);
                          //       } else if (_departureTimeController
                          //           .text.isEmpty) {
                          //          Get.snackbar(
                          //             "Failed", "Select Departure Time",
                          //             backgroundColor: Colors.purpleAccent);
                          //       } else if (_arrivalTimeController
                          //           .text.isEmpty) {
                          //          Get.snackbar(
                          //             "Failed", "Select Arrival Time",
                          //             backgroundColor: Colors.purpleAccent);
                          //       } else {
                          //         try {
                          //           int s =
                          //               int.parse(_totalSeatsController.text);
                          //           if (s <= 0) {
                          //             return Get.snackbar("Failed",
                          //                 "Number Of Seats Should Be Greater Than 0",
                          //                 backgroundColor: Colors.purpleAccent);
                          //           } else {
                          //             setState(() {
                          //               seats = s;
                          //             });
                          //           }
                          //         } catch (e) {
                          //           return Get.snackbar(
                          //               "Failed", "Input Number Of Seats",
                          //               backgroundColor: Colors.purpleAccent);
                          //         }
                          //         try {
                          //           int p = int.parse(_priceController.text);
                          //           if (p <= 1000) {
                          //             return Get.snackbar("Failed",
                          //                 "Price Should Be Greater Than 1000",
                          //                 backgroundColor: Colors.purpleAccent);
                          //           } else {
                          //             setState(() {
                          //               price = p;
                          //             });
                          //           }
                          //         } catch (e) {
                          //           return Get.snackbar("Failed", "Input Price",
                          //               backgroundColor: Colors.purpleAccent);
                          //         }
                          //         if (_departureIdController.text ==
                          //             _arrivalIdController.text) {
                          //           return Get.snackbar("Failed",
                          //               "Departure And Arrival Can Not Be The Same",
                          //               backgroundColor: Colors.purpleAccent);
                          //         } else {
                          //           setState(() {
                          //             isLoading = true;
                          //           });
                          //           var result = await updateTrip(
                          //               tripId: widget.trip.id,
                          //               arrivalLocationId:
                          //                   _arrivalIdController.text,
                          //               departureLocationId:
                          //                   _departureIdController.text,
                          //               companyId: widget.user.uid,
                          //               departureTime: departureTime,
                          //               eta: arrivalTime,
                          //               totalSeats: seats,
                          //               price: price,
                          //               ticketType: widget.trip.ticketType);
                          //           if (result == null) {
                          //             setState(() {
                          //               isLoading = false;
                          //             });
                          //             return Get.snackbar(
                          //                 "Failed To Added Trip", "Try Again",
                          //                 backgroundColor: Colors.purpleAccent);
                          //           } else {
                          //             setState(() {
                          //               isLoading = false;
                          //             });
                          //             Get.back();
                          //             Get.snackbar("Success", "Added Trip",
                          //                 backgroundColor: Colors.greenAccent);
                          //           }
                          //         }
                          //       }
                          //     },
                          //     child: Container(
                          //         alignment: Alignment.center,
                          //         height: 62,
                          //         decoration: BoxDecoration(
                          //             color: Colors.green[900],
                          //             borderRadius:
                          //                 BorderRadius.circular(20.0)),
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: const [
                          //             Icon(Icons.edit,color: Colors.white,),
                          //             SizedBox(width: 5,),
                          //             Text(
                          //               "Edit Trip",
                          //               style: TextStyle(
                          //                   fontSize: 20, color: Colors.white),
                          //             ),
                          //           ],
                          //         )),
                          //   ),
                          // ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: GestureDetector(
                              onTap: () async{
                                setState(() {
                                  isLoading = true;
                                });
                                bool result = await deleteTrip(tripId: widget.trip.id);
                                if(result == true){
                                  Get.back();
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 62,
                                  decoration: BoxDecoration(
                                      color: Colors.red[900],
                                      borderRadius: BorderRadius.circular(20.0)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.delete,color: Colors.white,),
                                      SizedBox(width: 5,),
                                      Text(
                                        "Delete Trip",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ],
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ));
  }

  dateTimePickerWidget(BuildContext context, bool isDeparture) {
    return DatePicker.showDatePicker(
      context,
      dateFormat: 'dd MMMM yyyy HH:mm',
      initialDateTime: DateTime.now(),
      minDateTime: DateTime(DateTime.now().year),
      maxDateTime: DateTime(DateTime.now().year + 1),
      onMonthChangeStartWithFirstDate: true,
      onConfirm: (dateTime, List<int> index) {
        DateTime selectedDate = dateTime;
        if (isDeparture) {
          setState(() {
            departureTime = selectedDate.toUtc();
            _departureTimeController.text =
                DateFormat('dd-MMM-yyyy - HH:mm').format(selectedDate);
          });
        } else {
          setState(() {
            arrivalTime = selectedDate.toUtc();
            _arrivalTimeController.text =
                DateFormat('dd-MMM-yyyy - HH:mm').format(selectedDate);
          });
        }
      },
    );
  }

  Future<void> showDestinations(
      BuildContext context, List<Destination> data, bool isDeparture) async {
    List sr = [];
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController _ctr = TextEditingController();
          return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                    content: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: LayoutBuilder(
                        builder: (ctx, constraints) {
                          return Column(
                            children: [
                              Container(
                                height: 50,
                                width: constraints.maxWidth,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: TextField(
                                      decoration: const InputDecoration(
                                          hintText: "Search Here",
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red))),
                                      controller: _ctr,
                                      onChanged: (val) {
                                        List l = [];
                                        setState(() {
                                          if (_ctr.text.isNotEmpty) {
                                            // data.add(_ctr.text);
                                            for (int i = 0;
                                                i < data.length;
                                                i++) {
                                              if (data[i]
                                                  .name
                                                  .toLowerCase()
                                                  .contains(_ctr.text
                                                      .toLowerCase())) {
                                                l.add(data[i]);
                                              }
                                            }
                                            sr = l;
                                            // print(l);
                                          } else {
                                            sr = l;
                                          }
                                        });
                                      },
                                    )),
                                    const Icon(Icons.search)
                                  ],
                                ),
                              ),
                              Container(
                                  height: constraints.maxHeight * 0.8,
                                  width: constraints.maxWidth,
                                  color: Colors.grey[200],
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: sr.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: sr.length,
                                          itemBuilder: (context1, int i) =>
                                              GestureDetector(
                                                onTap: () {
                                                  if (isDeparture) {
                                                    setState(() {
                                                      _departureController
                                                          .text = sr[i].name;
                                                      _departureIdController
                                                          .text = sr[i].id;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      _arrivalController.text =
                                                          sr[i].name;
                                                      _arrivalIdController
                                                          .text = sr[i].id;
                                                    });
                                                  }
                                                  Navigator.of(context).pop();
                                                },
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.arrow_right),
                                                    Text(sr[i].name),
                                                  ],
                                                ),
                                              ))
                                      : ListView.builder(
                                          itemCount: data.length,
                                          itemBuilder: (context1, int i) =>
                                              GestureDetector(
                                                onTap: () {
                                                  if (isDeparture) {
                                                    setState(() {
                                                      _departureController
                                                          .text = data[i].name;
                                                      _departureIdController
                                                          .text = data[i].id;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      _arrivalController.text =
                                                          data[i].name;
                                                      _arrivalIdController
                                                          .text = data[i].id;
                                                    });
                                                  }
                                                  Navigator.of(context).pop();
                                                },
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.arrow_right),
                                                    Text(data[i].name),
                                                  ],
                                                ),
                                              ))),
                            ],
                          );
                        },
                      ),
                    ),
                    actions: [],
                  ));
        });
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: size.width * 0.9,
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xffe5e5e5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
