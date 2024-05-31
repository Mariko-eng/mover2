import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/destination/destination.dart';
import 'package:bus_stop_develop_admin/models/trip.dart';
import 'package:bus_stop_develop_admin/views/shared/loading.dart';

class BusTripsNewView extends StatefulWidget {
  final BusCompany company;

  const BusTripsNewView({Key? key, required this.company}) : super(key: key);

  @override
  _BusTripsNewViewState createState() => _BusTripsNewViewState();
}

class _BusTripsNewViewState extends State<BusTripsNewView> {
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: LoadingWidget(),
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
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  // border: Border.all(),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Bus Plate N0",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.blue[900]),
                                      )
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: _busPlateNoController,
                                          minLines: 1,
                                          maxLines: 1,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              border: OutlineInputBorder()),
                                          validator: (String? val) {
                                            return null;
                                          },
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  // border: Border.all(),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Departure - Location",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.blue[900]),
                                      )
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: _departureController,
                                          readOnly: true,
                                          minLines: 1,
                                          maxLines: 1,
                                          onTap: () {
                                            _showDestinations(
                                                context, destinations, true);
                                          },
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              border: OutlineInputBorder()),
                                          validator: (String? val) {
                                            if (val != null) {
                                              if (val.trim().length < 3) {
                                                return "Required!";
                                              } else {
                                                return null;
                                              }
                                            } else {
                                              return "Required!";
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  // border: Border.all(),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Arrival - Location",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.blue[900]),
                                      )
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: _arrivalController,
                                          readOnly: true,
                                          minLines: 1,
                                          maxLines: 1,
                                          onTap: () {
                                            _showDestinations(
                                                context, destinations, false);
                                          },
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              border: OutlineInputBorder()),
                                          validator: (String? val) {
                                            if (val != null) {
                                              if (val.trim().length < 3) {
                                                return "Required!";
                                              } else {
                                                return null;
                                              }
                                            } else {
                                              return "Required!";
                                            }
                                          },
                                        ),
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
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Departure Time",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Colors.blue[900]),
                                            )
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                controller:
                                                    _departureTimeController,
                                                readOnly: true,
                                                minLines: 1,
                                                maxLines: 1,
                                                onTap: () {
                                                  _dateTimePickerWidget(
                                                      context, true);
                                                },
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 5),
                                                    border:
                                                        OutlineInputBorder()),
                                                validator: (String? val) {
                                                  if (val != null) {
                                                    if (val.trim().length < 3) {
                                                      return "Required!";
                                                    } else {
                                                      return null;
                                                    }
                                                  } else {
                                                    return "Required!";
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Arrival Time",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Colors.blue[900]),
                                            )
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                controller:
                                                    _arrivalTimeController,
                                                readOnly: true,
                                                minLines: 1,
                                                maxLines: 1,
                                                onTap: () {
                                                  _dateTimePickerWidget(
                                                      context, false);
                                                },
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 5),
                                                    border:
                                                        OutlineInputBorder()),
                                                validator: (String? val) {
                                                  if (val != null) {
                                                    if (val.trim().length < 3) {
                                                      return "Required!";
                                                    } else {
                                                      return null;
                                                    }
                                                  } else {
                                                    return "Required!";
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Select Trip's Ticket Type",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: Colors.blue[900]),
                                    )
                                  ],
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
                              ],
                            ),
                            Visibility(
                                visible: !isTripHavingVIP,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            // border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Number Of Seats",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color:
                                                              Colors.blue[900]),
                                                )
                                              ],
                                            ),
                                            Divider(),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    controller:
                                                        _totalSeatsOrdinaryController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        5),
                                                        border:
                                                            OutlineInputBorder()),
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
                                                    validator: (String? val) {
                                                      if (val != null) {
                                                        if (val
                                                            .trim()
                                                            .isEmpty) {
                                                          return "Required!";
                                                        } else {
                                                          return null;
                                                        }
                                                      } else {
                                                        return "Required!";
                                                      }
                                                    },
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            // border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Ticket Price",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color:
                                                              Colors.blue[900]),
                                                )
                                              ],
                                            ),
                                            Divider(),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    controller:
                                                        _ordinaryPriceController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        5),
                                                        border:
                                                            OutlineInputBorder()),
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
                                                    validator: (String? val) {
                                                      if (val != null) {
                                                        if (val
                                                            .trim()
                                                            .isEmpty) {
                                                          return "Required!";
                                                        } else {
                                                          return null;
                                                        }
                                                      } else {
                                                        return "Required!";
                                                      }
                                                    },
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            // border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Discount Price Of Ticket *Optional",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color:
                                                              Colors.blue[900]),
                                                )
                                              ],
                                            ),
                                            Divider(),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    controller:
                                                        _ordinaryDiscountPriceController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        5),
                                                        border:
                                                            OutlineInputBorder()),
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
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),

                                      // TextFieldContainerWidget(
                                      //   child: TextField(
                                      //     controller:
                                      //         _totalSeatsOrdinaryController,
                                      //     keyboardType:
                                      //         TextInputType.number,
                                      //     inputFormatters: [
                                      //       FilteringTextInputFormatter
                                      //           .digitsOnly
                                      //     ],
                                      //     style: const TextStyle(
                                      //         fontSize: 17),
                                      //     cursorColor: Colors.red,
                                      //     onChanged: (value) {
                                      //       setState(() {
                                      //         if (value
                                      //             .trim()
                                      //             .isNotEmpty) {
                                      //           seatsOrdinary =
                                      //               int.parse(value);
                                      //         }
                                      //       });
                                      //     },
                                      //     decoration:
                                      //         const InputDecoration(
                                      //       icon: Icon(
                                      //         Icons.people_outline,
                                      //         color: Color(0xff62020a),
                                      //       ),
                                      //       labelText: "Total Seats",
                                      //       labelStyle:
                                      //           TextStyle(fontSize: 14),
                                      //       border: InputBorder.none,
                                      //     ),
                                      //   ),
                                      // ),
                                      // TextFieldContainerWidget(
                                      //   child: TextField(
                                      //     controller:
                                      //         _ordinaryPriceController,
                                      //     keyboardType:
                                      //         TextInputType.number,
                                      //     inputFormatters: [
                                      //       FilteringTextInputFormatter
                                      //           .digitsOnly
                                      //     ],
                                      //     style: const TextStyle(
                                      //         fontSize: 17),
                                      //     cursorColor: Colors.red,
                                      //     onChanged: (value) {
                                      //       setState(() {
                                      //         if (value
                                      //             .trim()
                                      //             .isNotEmpty) {
                                      //           ordinaryPrice =
                                      //               int.parse(value);
                                      //         }
                                      //       });
                                      //     },
                                      //     decoration:
                                      //         const InputDecoration(
                                      //       icon: Icon(
                                      //         Icons.money_off,
                                      //         color: Color(0xff62020a),
                                      //       ),
                                      //       labelText: "Price",
                                      //       labelStyle:
                                      //           TextStyle(fontSize: 14),
                                      //       border: InputBorder.none,
                                      //     ),
                                      //   ),
                                      // ),
                                      // TextFieldContainerWidget(
                                      //   child: TextField(
                                      //     controller:
                                      //         _ordinaryDiscountPriceController,
                                      //     keyboardType:
                                      //         TextInputType.number,
                                      //     inputFormatters: [
                                      //       FilteringTextInputFormatter
                                      //           .digitsOnly
                                      //     ],
                                      //     style: const TextStyle(
                                      //         fontSize: 17),
                                      //     cursorColor: Colors.red,
                                      //     onChanged: (value) {
                                      //       setState(() {
                                      //         if (value
                                      //             .trim()
                                      //             .isNotEmpty) {
                                      //           ordinaryDiscountPrice =
                                      //               int.parse(value);
                                      //         }
                                      //       });
                                      //     },
                                      //     decoration:
                                      //         const InputDecoration(
                                      //       icon: Icon(
                                      //         Icons.money_off,
                                      //         color: Color(0xff62020a),
                                      //       ),
                                      //       labelText: "Discount Price",
                                      //       labelStyle:
                                      //           TextStyle(fontSize: 14),
                                      //       border: InputBorder.none,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                )),
                            Visibility(
                              visible: isTripHavingVIP,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Ordinary Tickets".toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: Colors.blue[900],
                                                  fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Number Of Seats - Ordinary",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Colors.blue[900]),
                                            )
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                controller:
                                                    _totalSeatsOrdinaryController,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 5),
                                                    border:
                                                        OutlineInputBorder()),
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
                                                validator: (String? val) {
                                                  if (val != null) {
                                                    if (val.trim().isEmpty) {
                                                      return "Required!";
                                                    } else {
                                                      return null;
                                                    }
                                                  } else {
                                                    return "Required!";
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Ticket Price - Ordinary",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color: Colors
                                                                .blue[900]),
                                                  )
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: TextFormField(
                                                      controller:
                                                          _ordinaryPriceController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly
                                                      ],
                                                      decoration: InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          5),
                                                          border:
                                                              OutlineInputBorder()),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          if (value
                                                              .trim()
                                                              .isNotEmpty) {
                                                            ordinaryPrice =
                                                                int.parse(
                                                                    value);
                                                          }
                                                        });
                                                      },
                                                      validator: (String? val) {
                                                        if (val != null) {
                                                          if (val
                                                              .trim()
                                                              .isEmpty) {
                                                            return "Required!";
                                                          } else {
                                                            return null;
                                                          }
                                                        } else {
                                                          return "Required!";
                                                        }
                                                      },
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Discount Price *(Optional)",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color: Colors
                                                                .blue[900]),
                                                  )
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: TextFormField(
                                                      controller:
                                                          _ordinaryDiscountPriceController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly
                                                      ],
                                                      decoration: InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          5),
                                                          border:
                                                              OutlineInputBorder()),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          if (value
                                                              .trim()
                                                              .isNotEmpty) {
                                                            ordinaryDiscountPrice =
                                                                int.parse(
                                                                    value);
                                                          }
                                                        });
                                                      },
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Visibility(
                              visible: isTripHavingVIP,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "VIP Tickets".toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: Colors.blue[900],
                                                  fontWeight: FontWeight.w900),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Number of Seats - VIP",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Colors.blue[900]),
                                            )
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                controller:
                                                    _totalSeatsVIPController,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 5),
                                                    border:
                                                        OutlineInputBorder()),
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
                                                validator: (String? val) {
                                                  if (val != null) {
                                                    if (val.trim().isEmpty) {
                                                      return "Required!";
                                                    } else {
                                                      return null;
                                                    }
                                                  } else {
                                                    return "Required!";
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Ticket Price - VIP",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color: Colors
                                                                .blue[900]),
                                                  )
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: TextFormField(
                                                      controller:
                                                          _vipPriceController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly
                                                      ],
                                                      decoration: InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          5),
                                                          border:
                                                              OutlineInputBorder()),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          if (value
                                                              .trim()
                                                              .isNotEmpty) {
                                                            vipPrice =
                                                                int.parse(
                                                                    value);
                                                          }
                                                        });
                                                      },
                                                      validator: (String? val) {
                                                        if (val != null) {
                                                          if (val
                                                              .trim()
                                                              .isEmpty) {
                                                            return "Required!";
                                                          } else {
                                                            return null;
                                                          }
                                                        } else {
                                                          return "Required!";
                                                        }
                                                      },
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Discount Price *(Optional)",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color: Colors
                                                                .blue[900]),
                                                  )
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: TextFormField(
                                                      controller:
                                                          _vipDiscountPriceController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly
                                                      ],
                                                      decoration: InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          5),
                                                          border:
                                                              OutlineInputBorder()),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          if (value
                                                              .trim()
                                                              .isNotEmpty) {
                                                            vipDiscountPrice =
                                                                int.parse(
                                                                    value);
                                                          }
                                                        });
                                                      },
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () async {
                                        bool isValid =
                                            _formKey.currentState!.validate();
                                        if (isValid) {
                                          if (isTripHavingVIP) {
                                            _addOrdinaryXVIPTrip(
                                                isPublished: false);
                                          } else {
                                            _addOrdinaryTrip(
                                                isPublished: false);
                                          }
                                        } else {
                                          print("InValid");
                                        }
                                      },
                                      child: Container(
                                          alignment: Alignment.center,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: const Color(0xff62020a),
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: const Text(
                                            "Save Trip As Draft",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white),
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () async {
                                        bool isValid =
                                            _formKey.currentState!.validate();
                                        if (isValid) {
                                          if (isTripHavingVIP) {
                                            _addOrdinaryXVIPTrip(
                                                isPublished: true);
                                          } else {
                                            _addOrdinaryTrip(isPublished: true);
                                          }
                                        } else {
                                          print("InValid");
                                        }
                                      },
                                      child: Container(
                                          alignment: Alignment.center,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: const Color(0xff62020a),
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: const Text(
                                            "Save & Publish Trip",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ));
  }

  _addOrdinaryTrip({required bool isPublished}) async {
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
        totalOrdinarySeats: seatsOrdinary,
        price: ordinaryPrice,
        discountPrice: ordinaryDiscountPrice,
        priceOrdinary: ordinaryPrice,
        discountPriceOrdinary: ordinaryDiscountPrice,
        priceVip: 0,
        discountPriceVip: 0,
        tripType: "Ordinary",
        isPublished: isPublished);

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

  _addOrdinaryXVIPTrip({required bool isPublished}) async {
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
        tripType: "Ordinary-X-VIP",
        isPublished: isPublished);
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
      initialDateTime:
          isDeparture ? departureTime : arrivalTime ?? DateTime.now(),
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
