import 'package:flutter/material.dart';
import 'package:bus_stop_develop_admin/models/reports.dart';
import 'package:bus_stop_develop_admin/models/ticket.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/widgets/TicketTile.dart';

class SuperAdminReportTripTicketsListView extends StatefulWidget {
  final ReportModel reportModel;

  const SuperAdminReportTripTicketsListView({super.key, required this.reportModel});

  @override
  State<SuperAdminReportTripTicketsListView> createState() => _ReportTripTicketsState();
}

class _ReportTripTicketsState extends State<SuperAdminReportTripTicketsListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xfffdfdfd),
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
                width: 20,
                height: 25,
                child: Image.asset(
                  'assets/images/back_arrow.png',
                )),
          ),
          title: Text(
            widget.reportModel.trip.departureLocationName +
                " - " +
                widget.reportModel.trip.arrivalLocationName +
                " Tickets".toUpperCase(),
            style: TextStyle(color: Colors.red[900]),
          )),
      body: widget.reportModel.tickets.isEmpty
          ? const Center(
        child: Text("No  Tickets Bought Yet"),
      )
          : Column(
        children: [
          Expanded(
              child: ListView.builder(
                itemCount: widget.reportModel.tickets.length,
                itemBuilder: (context, index) {
                  return FutureBuilder(
                    future: widget.reportModel.tickets[index]
                        .setTripData(context),
                    // ignore: missing_return
                    builder: (context, snapshot) {
                      TripTicket? ticket = snapshot.data;
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          if (index == 0) {
                            return Container();
                          }

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
                          return ticket == null
                              ? Container()
                              : SuperAdminTicketTile(
                              tripTicket: ticket);
                      }
                    },
                  );
                },
              ))
        ],
      ),
    );
  }
}
