import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/reports.dart';
import 'package:bus_stop_develop_admin/models/ticket.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/TicketTile.dart';
import 'package:flutter/material.dart';

class ReportTripTickets extends StatefulWidget {
  final BusCompany company;
  final ReportModel reportModel;

  const ReportTripTickets({super.key, required this.reportModel, required this.company});

  @override
  State<ReportTripTickets> createState() => _ReportTripTicketsState();
}

class _ReportTripTicketsState extends State<ReportTripTickets> {
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
                                : TicketTile(
                                    company: widget.company, tripTicket: ticket);
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
