import 'package:bus_stop_develop_admin/views/pages/busAdmin/reports/reports_trips/tickets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              future: getReportsForBusCompany(
                  date: widget.dateTime, companyId: widget.company.uid),
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
                  List<ReportModel>? data = snapshot.data;
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
                      child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, int i) {
                          return Card(
                            child: ListTile(
                              onTap: () {
                                Get.to(() => BusAdminReportTripTicketsListView(
                                    company: widget.company,
                                    reportModel: data[i]));
                              },
                              leading: const Icon(
                                Icons.bus_alert,
                                color: Colors.red,
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    data[i].trip.departureLocationName,
                                  ),
                                  Icon(Icons.arrow_circle_right_rounded),
                                  Text(
                                    data[i].trip.arrivalLocationName,
                                  ),
                                ],
                              ),
                              trailing: Text(
                                data[i].tickets.length.toString(),
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 30,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.red[900],
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "View Tickets",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ));
                }
              }),
        ],
      ),
    );
  }
}
