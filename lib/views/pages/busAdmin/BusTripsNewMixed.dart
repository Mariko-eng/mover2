import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/destination/destination.dart';
import 'package:bus_stop_develop_admin/models/trip.dart';
import 'package:bus_stop_develop_admin/views/shared/loading.dart';
import 'package:bus_stop_develop_admin/views/shared/text_field_widget.dart';

class BusTripsNewMixed extends StatefulWidget {
  final BusCompany company;
  const BusTripsNewMixed({Key? key, required this.company}) : super(key: key);

  @override
  _BusTripsNewMixedState createState() => _BusTripsNewMixedState();
}

class _BusTripsNewMixedState extends State<BusTripsNewMixed> {
  final _busPlateNoController = TextEditingController();
  final _arrivalController = TextEditingController();
  final _arrivalIdController = TextEditingController();
  final _departureController = TextEditingController();
  final _departureIdController = TextEditingController();
  final _departureTimeController = TextEditingController();
  final _arrivalTimeController = TextEditingController();
  final _ordinaryPriceController = TextEditingController();
  final _ordinaryDiscountPriceController = TextEditingController();
  final _totalSeatsOrdinaryController = TextEditingController();
  final _vipPriceController = TextEditingController();
  final _vipDiscountPriceController = TextEditingController();
  final _totalSeatsVIPController = TextEditingController();

  DateTime? departureTime = DateTime.now();
  DateTime? arrivalTime;

  int seatsOrdinary = 0;
  int seatsVIP = 0;

  int ordinaryPrice = 0;
  int ordinaryDiscountPrice = 0;

  int vipPrice = 0;
  int vipDiscountPrice = 0;

  bool isLoading = false;

  bool isTripHavingVIP = false;

  @override
  Widget build(BuildContext context) {
    // final UserProvider userProvider = Provider.of<UserProvider>(context);

    return isLoading
        ? Scaffold(
            body: Loading(),
          )
        : Scaffold(
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.grey[200],
                iconTheme: IconThemeData(color: Color(0xff62020a)),
                centerTitle: true,
                title: const Text(
                  "Add New Trip",
                  style: TextStyle(color: Color(0xff62020a)),
                )),
            body: FutureBuilder(
                    future: getDestinations(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                      }
                      if (snapshot.hasData) {
                        List<Destination> destinations = snapshot.data;
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextFieldContainerWidget(
                                  child: TextField(
                                    controller: _busPlateNoController,
                                    style: const TextStyle(fontSize: 20),
                                    cursorColor: Colors.red,
                                    decoration: const InputDecoration(
                                      icon: Icon(
                                        Icons.bus_alert_outlined,
                                        color: Color(0xff62020a),
                                      ),
                                      labelText: "Bus Plate Number",
                                      labelStyle: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                TextFieldContainerWidget(
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
                                      labelText: "Source - Location",
                                      labelStyle: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    onTap: () {
                                      _showDestinations(
                                          context, destinations, true);
                                    },
                                  ),
                                ),
                                TextFieldContainerWidget(
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
                                      labelText: "Destination - Location",
                                      labelStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    onTap: () {
                                      _showDestinations(
                                          context, destinations, false);
                                    },
                                  ),
                                ),
                                TextFieldContainerWidget(
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
                                      labelText: "Departure Time",
                                      labelStyle: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    onTap: () {
                                      _dateTimePickerWidget(context, true);
                                    },
                                  ),
                                ),
                                TextFieldContainerWidget(
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
                                      labelText: "Arrival Time",
                                      labelStyle: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    onTap: () {
                                      _dateTimePickerWidget(context, false);
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Radio(
                                              value: false,
                                              groupValue: isTripHavingVIP,
                                              onChanged: (val) {
                                                setState(() {
                                                  isTripHavingVIP = false;
                                                });
                                              }),
                                          const Text(
                                            "ONLY ORDINARY",
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30.0,
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Radio(
                                            value: true,
                                            groupValue: isTripHavingVIP,
                                            onChanged: (val) {
                                              setState(() {
                                                isTripHavingVIP = true;
                                              });
                                            },
                                          ),
                                          const Text(
                                            "ORDINARY + VIP",
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                !isTripHavingVIP
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextFieldContainerWidget(
                                              child: TextField(
                                                controller:
                                                    _totalSeatsOrdinaryController,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                style: const TextStyle(
                                                    fontSize: 17),
                                                cursorColor: Colors.red,
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value
                                                        .trim()
                                                        .isNotEmpty) {
                                                      seatsOrdinary =
                                                          int.parse(value);
                                                    }
                                                  });
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  icon: Icon(
                                                    Icons.people_outline,
                                                    color: Color(0xff62020a),
                                                  ),
                                                  labelText: "Total Seats",
                                                  labelStyle:
                                                      TextStyle(fontSize: 14),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            TextFieldContainerWidget(
                                              child: TextField(
                                                controller:
                                                    _ordinaryPriceController,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                style: const TextStyle(
                                                    fontSize: 17),
                                                cursorColor: Colors.red,
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value
                                                        .trim()
                                                        .isNotEmpty) {
                                                      ordinaryPrice =
                                                          int.parse(value);
                                                    }
                                                  });
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  icon: Icon(
                                                    Icons.money_off,
                                                    color: Color(0xff62020a),
                                                  ),
                                                  labelText: "Price",
                                                  labelStyle:
                                                      TextStyle(fontSize: 14),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            TextFieldContainerWidget(
                                              child: TextField(
                                                controller:
                                                    _ordinaryDiscountPriceController,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                style: const TextStyle(
                                                    fontSize: 17),
                                                cursorColor: Colors.red,
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value
                                                        .trim()
                                                        .isNotEmpty) {
                                                      ordinaryDiscountPrice =
                                                          int.parse(value);
                                                    }
                                                  });
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  icon: Icon(
                                                    Icons.money_off,
                                                    color: Color(0xff62020a),
                                                  ),
                                                  labelText: "Discount Price",
                                                  labelStyle:
                                                      TextStyle(fontSize: 14),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                                isTripHavingVIP
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextFieldContainerWidget(
                                              child: TextField(
                                                controller:
                                                    _totalSeatsOrdinaryController,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                style: const TextStyle(
                                                    fontSize: 17),
                                                cursorColor: Colors.red,
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value
                                                        .trim()
                                                        .isNotEmpty) {
                                                      seatsOrdinary =
                                                          int.parse(value);
                                                    }
                                                  });
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  icon: Icon(
                                                    Icons.people_outline,
                                                    color: Color(0xff62020a),
                                                  ),
                                                  labelText: "Seats (Ordinary)",
                                                  labelStyle:
                                                      TextStyle(fontSize: 14),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            TextFieldContainerWidget(
                                              child: TextField(
                                                controller:
                                                    _ordinaryPriceController,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                style: const TextStyle(
                                                    fontSize: 17),
                                                cursorColor: Colors.red,
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value
                                                        .trim()
                                                        .isNotEmpty) {
                                                      ordinaryPrice =
                                                          int.parse(value);
                                                    }
                                                  });
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  icon: Icon(
                                                    Icons.money_off,
                                                    color: Color(0xff62020a),
                                                  ),
                                                  labelText: "Price (Ordinary)",
                                                  labelStyle:
                                                      TextStyle(fontSize: 14),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            TextFieldContainerWidget(
                                              child: TextField(
                                                controller:
                                                    _ordinaryDiscountPriceController,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                style: const TextStyle(
                                                    fontSize: 17),
                                                cursorColor: Colors.red,
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value
                                                        .trim()
                                                        .isNotEmpty) {
                                                      ordinaryDiscountPrice =
                                                          int.parse(value);
                                                    }
                                                  });
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  icon: Icon(
                                                    Icons.money_off,
                                                    color: Color(0xff62020a),
                                                  ),
                                                  labelText:
                                                      "Discount Price (Ordinary)",
                                                  labelStyle:
                                                      TextStyle(fontSize: 14),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                                isTripHavingVIP
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextFieldContainerWidget(
                                              child: TextField(
                                                controller:
                                                    _totalSeatsVIPController,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                style: const TextStyle(
                                                    fontSize: 17),
                                                cursorColor: Colors.red,
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value
                                                        .trim()
                                                        .isNotEmpty) {
                                                      seatsVIP =
                                                          int.parse(value);
                                                    }
                                                  });
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  icon: Icon(
                                                    Icons.people_outline,
                                                    color: Color(0xff62020a),
                                                  ),
                                                  labelText: "Seats (VIP)",
                                                  labelStyle:
                                                      TextStyle(fontSize: 14),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            TextFieldContainerWidget(
                                              child: TextField(
                                                controller: _vipPriceController,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                style: const TextStyle(
                                                    fontSize: 17),
                                                cursorColor: Colors.red,
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value
                                                        .trim()
                                                        .isNotEmpty) {
                                                      vipPrice =
                                                          int.parse(value);
                                                    }
                                                  });
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  icon: Icon(
                                                    Icons.money_off,
                                                    color: Color(0xff62020a),
                                                  ),
                                                  labelText: "Price (VIP)",
                                                  labelStyle:
                                                      TextStyle(fontSize: 14),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            TextFieldContainerWidget(
                                              child: TextField(
                                                controller:
                                                    _vipDiscountPriceController,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                style: const TextStyle(
                                                    fontSize: 17),
                                                cursorColor: Colors.red,
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value
                                                        .trim()
                                                        .isNotEmpty) {
                                                      vipDiscountPrice =
                                                          int.parse(value);
                                                    }
                                                  });
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  icon: Icon(
                                                    Icons.money_off,
                                                    color: Color(0xff62020a),
                                                  ),
                                                  labelText:
                                                      "Discount Price (VIP)",
                                                  labelStyle:
                                                      TextStyle(fontSize: 14),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (_busPlateNoController.text.trim().length < 3) {
                                        Get.snackbar("Sorry",
                                            "Enter Bus Plate Number",
                                            backgroundColor:
                                            Colors.purpleAccent);
                                      } else if (_departureIdController.text.isEmpty) {
                                        Get.snackbar("Sorry",
                                            "Select Source/ Departure Location",
                                            backgroundColor:
                                                Colors.purpleAccent);
                                      } else if (_arrivalIdController
                                          .text.isEmpty) {
                                        Get.snackbar("Sorry",
                                            "Select Destination Location",
                                            backgroundColor:
                                                Colors.purpleAccent);
                                      } else if (_departureTimeController
                                          .text.isEmpty) {
                                        Get.snackbar(
                                            "Sorry", "Select Departure Time",
                                            backgroundColor:
                                                Colors.purpleAccent);
                                      } else if (_arrivalTimeController
                                          .text.isEmpty) {
                                        Get.snackbar(
                                            "Sorry", "Select Arrival Time",
                                            backgroundColor:
                                                Colors.purpleAccent);
                                      } else if (isTripHavingVIP) {
                                        _addOrdinaryXVIPTrip();
                                      } else {
                                        _addOrdinaryTrip();
                                      }
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        height: 62,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff62020a),
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        child: const Text(
                                          "Add Trip",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        )),
                                  ),
                                ),
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

    _addOrdinaryTrip() async {
      if (seatsOrdinary <= 0) {
      Get.snackbar("Failed", "Number Of Seats Should Be Greater Than 0",
          backgroundColor: Colors.purpleAccent);
      return;
    }
    if (ordinaryPrice <= 1000) {
      Get.snackbar("Failed", "Number Of Seats Should Be Greater Than 0",
          backgroundColor: Colors.purpleAccent);
      return;
    }

    if (_ordinaryDiscountPriceController.text.trim().isNotEmpty) {
      if (ordinaryDiscountPrice < 1000) {
        Get.snackbar("Failed", "Discount Price Should Be Greater Than 1000",
            backgroundColor: Colors.purpleAccent);
        return;
      }
    }
    setState(() {
      isLoading = true;
    });

    var result = await addTripOrdinaryOnly(
      companyId: widget.company.uid,
      companyName: widget.company.name,
      busPlateNo: _busPlateNoController.text.trim(),
      departureLocationName: _departureController.text,
      departureLocationId: _departureIdController.text,
      arrivalLocationName: _arrivalController.text,
      arrivalLocationId: _arrivalIdController.text,
      departureTime: departureTime!,
      arrivalTime: arrivalTime!,
      totalSeats: seatsOrdinary,
      price: ordinaryPrice,
      discountPrice: ordinaryDiscountPrice,
      totalOrdinarySeats: seatsOrdinary,
      priceOrdinary: ordinaryPrice,
      discountPriceOrdinary: ordinaryDiscountPrice,
      priceVip: 0,
      discountPriceVip: 0,
      tripType: "Ordinary",
    );
    if (result == null) {
      setState(() {
        isLoading = false;
      });
      Get.snackbar("Failed To Added Trip", "Try Again",
          backgroundColor: Colors.purpleAccent);
    } else {
      setState(() {
        isLoading = false;
      });
      Get.back();
      Get.snackbar("Success", "Added Trip",
          backgroundColor: Colors.greenAccent);
    }
  }
   _addOrdinaryXVIPTrip() async {
      if (seatsOrdinary <= 0) {
      Get.snackbar(
          "Failed", "Ordinary Number Of Seats Should Be Greater Than 0",
          backgroundColor: Colors.purpleAccent);
      return;
    }
    if (ordinaryPrice <= 1000) {
      Get.snackbar("Failed", "Ordinary Price Should Be Greater Than 1000",
          backgroundColor: Colors.purpleAccent);
      return;
    }

    if (_ordinaryDiscountPriceController.text.trim().isNotEmpty) {
      if (ordinaryDiscountPrice < 1000) {
        Get.snackbar("Failed", "Discount Price Should Be Greater Than 1000",
            backgroundColor: Colors.purpleAccent);
        return;
      }
    }

    if (seatsVIP <= 0) {
      Get.snackbar("Failed", "Number Of VIP Seats Should Be Greater Than 0",
          backgroundColor: Colors.purpleAccent);
      return;
    }

    if (vipPrice <= 1000) {
      Get.snackbar("Failed", "VIP Price Should Be Greater Than 1000",
          backgroundColor: Colors.purpleAccent);
      return;
    }

    if (_vipDiscountPriceController.text.trim().isNotEmpty) {
      if (vipDiscountPrice < 1000) {
        Get.snackbar("Failed", "VIP Discount Price Should Be Greater Than 1000",
            backgroundColor: Colors.purpleAccent);
        return;
      }
    }

    // print(vipPrice);
    // print(vipDiscountPrice);

    setState(() {
      isLoading = true;
    });
    var result = await addTripOrdinaryAndVIP(
        companyId: widget.company.uid,
        companyName: widget.company.name,
        busPlateNo: _busPlateNoController.text.trim(),
        departureLocationName: _departureController.text,
        departureLocationId: _departureIdController.text,
        arrivalLocationName: _arrivalController.text,
        arrivalLocationId: _arrivalIdController.text,
        departureTime: departureTime!,
        arrivalTime: arrivalTime!,
        totalSeats: seatsOrdinary + seatsVIP,
        price: ordinaryPrice,
        discountPrice: ordinaryDiscountPrice,
        totalOrdinarySeats: seatsOrdinary,
        priceOrdinary: ordinaryPrice,
        discountPriceOrdinary: ordinaryDiscountPrice,
        totalVipSeats: seatsVIP,
        priceVip: vipPrice,
        discountPriceVip: vipDiscountPrice,
        tripType: "Ordinary-X-VIP");
    if (result == null) {
      setState(() {
        isLoading = false;
      });
      Get.snackbar("Failed To Added Trip", "Try Again",
          backgroundColor: Colors.purpleAccent);
    } else {
      setState(() {
        isLoading = false;
      });
      Get.back();
      Get.snackbar("Success", "Added Trip",
          backgroundColor: Colors.greenAccent);
    }
  }

  _dateTimePickerWidget(BuildContext context, bool isDeparture) {
    return DatePicker.showDatePicker(
      context,
      dateFormat: 'dd MMMM yyyy HH:mm',
      initialDateTime: isDeparture ? departureTime : arrivalTime ?? DateTime.now(),
      minDateTime: DateTime(DateTime.now().year),
      maxDateTime: DateTime(DateTime.now().year + 3),
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

  Future<void> _showDestinations(
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
