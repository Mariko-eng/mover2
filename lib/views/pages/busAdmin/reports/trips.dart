import 'package:flutter/material.dart';
import 'package:bus_stop_develop_admin/models/trip.dart';
import 'package:bus_stop_develop_admin/views/shared/utils.dart';
import 'package:bus_stop_develop_admin/models/reports.dart';
import 'package:bus_stop_develop_admin/models/busCompany.dart';

class BusAdminReportTripsListView extends StatefulWidget {
  final BusCompany company;

  const BusAdminReportTripsListView({super.key, required this.company});

  @override
  State<BusAdminReportTripsListView> createState() =>
      _BusCompanyReportTripsListViewState();
}

class _BusCompanyReportTripsListViewState
    extends State<BusAdminReportTripsListView> {
  List<String> _years = [];
  late String _selectedYear;
  late String _selectedMonth;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    setState(() {
      // Get the current year
      int currentYear = DateTime.now().year;
      int currentMonth = DateTime.now().month;

      // Generate a list of years from 2000 to the current year
      _years = List.generate(
          currentYear - 1999, (index) => (2000 + index).toString());

      // Set the current year as the selected value
      _selectedYear = currentYear.toString();
      _selectedMonth = currentMonth.toString();
      _selectedDate = DateTime(currentYear, currentMonth);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Filters",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 18,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 5,
          ),
          LayoutBuilder(builder: (context, constraints) {
            return SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  DropdownMenu(
                    menuHeight: 300,
                    width: constraints.maxWidth * 0.45,
                    initialSelection: _selectedYear,
                    helperText: "Year",
                    dropdownMenuEntries: _years
                        .map((item) =>
                            DropdownMenuEntry(value: item, label: item))
                        .toList(),
                    onSelected: (String? val) {
                      if (val != null) {
                        setState(() {
                          int yearValue = int.parse(val);
                          int monthValue = int.parse(_selectedMonth);
                          _selectedYear = val;
                          _selectedDate = DateTime(yearValue, monthValue);
                          // print("_selectedDate : " +
                          //     _selectedDate.toString());
                        });
                      }
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  DropdownMenu(
                    menuHeight: 300,
                    width: constraints.maxWidth * 0.45,
                    initialSelection: _selectedMonth,
                    helperText: "Month",
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: "1", label: "Jan"),
                      DropdownMenuEntry(value: "2", label: "Feb"),
                      DropdownMenuEntry(value: "3", label: "Mar"),
                      DropdownMenuEntry(value: "4", label: "Apr"),
                      DropdownMenuEntry(value: "5", label: "May"),
                      DropdownMenuEntry(value: "6", label: "Jun"),
                      DropdownMenuEntry(value: "7", label: "Jul"),
                      DropdownMenuEntry(value: "8", label: "Aug"),
                      DropdownMenuEntry(value: "9", label: "Sept"),
                      DropdownMenuEntry(value: "10", label: "Oct"),
                      DropdownMenuEntry(value: "11", label: "Nov"),
                      DropdownMenuEntry(value: "12", label: "Dec"),
                    ],
                    onSelected: (String? val) {
                      if (val != null) {
                        setState(() {
                          int yearValue = int.parse(_selectedYear);
                          int monthValue = int.parse(val);
                          _selectedMonth = val;
                          _selectedDate = DateTime(yearValue, monthValue);
                          // print("_selectedDate : " +
                          //     _selectedDate.toString());
                        });
                      }
                    },
                  ),
                ],
              ),
            );
          }),
          SizedBox(
            height: 10,
          ),
          FutureBuilder(
              future: getTripReportsForBusCompany(
                  selectedDate: _selectedDate, companyId: widget.company.uid),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Expanded(
                      child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Something has Gone Wrong!"),
                      ],
                    ),
                  ));
                }
                if (!snapshot.hasData) {
                  return const Expanded(
                      child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  ));
                } else {
                  List<Trip>? data = snapshot.data;
                  if (data == null) {
                    return Expanded(
                        child: Center(
                            child: Text(
                      "No Data Found!",
                      textAlign: TextAlign.center,
                    )));
                  }
                  if (data.isEmpty) {
                    return Expanded(
                        child: Center(
                            child: Text(
                      "No Data Found!",
                      textAlign: TextAlign.center,
                    )));
                  }
                  return Expanded(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.blue[100]!.withOpacity(0.3),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Summary",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total : ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: Colors.black, fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    data.length.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: Colors.blue[900],
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, int index) {
                                Trip trip = data[index];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.grey[200]),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.red[100],
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(trip.tripType
                                                    .toUpperCase()),
                                                trip.isClosed == false
                                                    ? Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 5,
                                                                vertical: 2),
                                                        color: Colors.green,
                                                        child: Text(
                                                          "Open",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )
                                                    : Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 5,
                                                                vertical: 2),
                                                        color: Colors.black,
                                                        child: Text(
                                                          "Closed",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                        dateToTime(
                                                            trip.departureTime),
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
                                                  Text(
                                                      trip.arrivalLocationName),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Icon(
                                                    Icons.lock_clock,
                                                    size: 15,
                                                  ),
                                                  Text(
                                                    dateToStringNew(
                                                            trip.arrivalTime) +
                                                        "/" +
                                                        dateToTime(
                                                            trip.arrivalTime),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.red[900]),
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
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )),
                      ],
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
