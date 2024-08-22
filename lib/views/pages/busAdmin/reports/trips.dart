import 'package:flutter/material.dart';
import 'package:bus_stop_develop_admin/models/trip.dart';
import 'package:bus_stop_develop_admin/views/shared/utils.dart';
import 'package:bus_stop_develop_admin/models/reports.dart';
import 'package:bus_stop_develop_admin/models/busCompany.dart';

class BusAdminReportTripsListView extends StatefulWidget {
  final BusCompany company;
  final DateTime dateTime;
  final TextEditingController dateInput;

  const BusAdminReportTripsListView(
      {super.key,
        required this.company,
        required this.dateTime,
        required this.dateInput});

  @override
  State<BusAdminReportTripsListView> createState() =>
      _BusCompanyReportTripsListViewState();
}

class _BusCompanyReportTripsListViewState
    extends State<BusAdminReportTripsListView> {
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
          FutureBuilder(
              future: getTripReportsForBusCompany(
                  selectedDate: widget.dateTime, companyId: widget.company.uid),
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
                              "${widget.dateInput.text}\n No Data Found!",
                              textAlign: TextAlign.center,
                            )));
                  }
                  if (data.isEmpty) {
                    return Expanded(
                        child: Center(
                            child: Text(
                              "${widget.dateInput.text}\n No Data Found!",
                              textAlign: TextAlign.center,
                            )));
                  }
                  return Expanded(
                    child: Column(
                      children: [
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Results",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                        color: Colors.black,
                                        fontSize: 18,
                                    fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("No Of Trips : ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                        color: Colors.black,
                                        fontSize: 14),
                                  ),
                                  SizedBox(width: 10,),
                                  Text("33",
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
                                                  borderRadius: const BorderRadius.only(
                                                      topLeft: Radius.circular(10),
                                                      topRight: Radius.circular(10))),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(trip.tripType.toUpperCase()),
                                                    trip.isClosed == false
                                                        ? Container(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 5, vertical: 2),
                                                      color: Colors.green,
                                                      child: Text(
                                                        "Open",
                                                        style:
                                                        TextStyle(color: Colors.white),
                                                      ),
                                                    )
                                                        : Container(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 5, vertical: 2),
                                                      color: Colors.black,
                                                      child: Text(
                                                        "Closed",
                                                        style:
                                                        TextStyle(color: Colors.white),
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
                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Trip:",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(trip.tripNumber)
                                                    ],
                                                  ),
                                                  Text(
                                                    trip.busPlateNo.toUpperCase(),
                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                  ),
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
