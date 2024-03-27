import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/ticket.dart';
import 'package:bus_stop_develop_admin/models/user/user.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/TicketTile.dart';
import 'package:bus_stop_develop_admin/views/shared/loading.dart';
import 'package:flutter/material.dart';

class BusTicketsActive extends StatefulWidget {
  // final AdminUserModel user;
  final BusCompany company;
  final String tripId;
  const BusTicketsActive({Key? key,required this.company,required this.tripId}) : super(key: key);

  @override
  _BusTicketsActiveState createState() => _BusTicketsActiveState();
}

class _BusTicketsActiveState extends State<BusTicketsActive> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: getMyBusCompanyActiveTickets(
            companyId: widget.company.uid,
          tripId: widget.tripId
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.hasData) {
            List<TripTicket>? tickets = snapshot.data;
            if (tickets!.isEmpty) {
              return const Center(
                child: Text(
                  'No tickets',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFE4191D),
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: tickets[index].setTripData(context),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    TripTicket? ticket = snapshot.data;
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        if (index == 0) {
                          return const LoadingWidget();
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
                        return ticket == null ? Container() :
                        TicketTile(
                            company: widget.company,
                            tripTicket: ticket);
                    }
                  },
                );
              },
            );
          }
          return Container();
        });
  }
}
