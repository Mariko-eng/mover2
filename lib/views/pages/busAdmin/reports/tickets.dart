import 'package:flutter/material.dart';
import 'package:bus_stop_develop_admin/models/ticket.dart';
import 'package:bus_stop_develop_admin/models/reports.dart';
import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/widgets/TicketTileReport.dart';

class BusAdminReportTicketsListView extends StatefulWidget {
  final BusCompany company;
  final DateTime dateTime;
  final TextEditingController dateInput;

  const BusAdminReportTicketsListView(
      {super.key,
        required this.company,
        required this.dateTime,
        required this.dateInput});

  @override
  State<BusAdminReportTicketsListView> createState() =>
      _BusCompanyReportTicketsListViewState();
}

class _BusCompanyReportTicketsListViewState
    extends State<BusAdminReportTicketsListView> {
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
              future: getTicketReportsForBusCompany(
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
                  List<TripTicket>? tickets = snapshot.data;
                  if (tickets == null) {
                    return Expanded(
                        child: Center(
                            child: Text(
                              "${widget.dateInput.text}\n No Data Found!",
                              textAlign: TextAlign.center,
                            )));
                  }
                  if (tickets.isEmpty) {
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
                            itemCount: tickets.length,
                            itemBuilder: (context, int index) {
                              return FutureBuilder(
                                future: tickets[index].setTripData(context),
                                // ignore: missing_return
                                builder: (context, snapshot) {
                                  TripTicket? ticket = snapshot.data;
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                    // if (index == 0) {
                                    //   return const LoadingWidget();
                                    // }
                                      return Container();
                                    case ConnectionState.none:
                                      return const Text(
                                        'No Tickets',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFFE4191D), fontSize: 20.0),
                                      );
                                    case ConnectionState.active:
                                      return const Text('Searching... ');
                                    case ConnectionState.done:
                                      return ticket == null ? Container() :
                                      BusAdminReportTicketTileWidget(
                                          company: widget.company,
                                          tripTicket: ticket);
                                  }
                                },
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
