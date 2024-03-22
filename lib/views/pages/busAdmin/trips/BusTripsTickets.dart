import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/ticket.dart';
import 'package:bus_stop_develop_admin/models/trip.dart';
import 'package:bus_stop_develop_admin/models/user/user.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/TicketTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../shared/loading.dart';

class BusCompanyTripsTickets extends StatefulWidget {
  // final AdminUserModel user;
  final BusCompany company;
  final Trip trip;

  const BusCompanyTripsTickets(
      {Key? key, required this.company, required this.trip})
      : super(key: key);

  @override
  _MyTicketsState createState() => _MyTicketsState();
}

class _MyTicketsState extends State<BusCompanyTripsTickets> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<TripTicket>>.value(
      initialData: const [],
      value: getMyBusCompanyTicketsForATrip(tripId: widget.trip.id),
      child: TicketList(
        company: widget.company,
        trip: widget.trip,
      ),
    );
  }
}

class TicketList extends StatefulWidget {
  // final AdminUserModel user;
  final BusCompany company;
  final Trip trip;

  const TicketList({Key? key, required this.company, required this.trip})
      : super(key: key);

  @override
  _TripsTicketListState createState() => _TripsTicketListState();
}

class _TripsTicketListState extends State<TicketList> {
  @override
  Widget build(BuildContext context) {
    final tickets = Provider.of<List<TripTicket>>(context) ?? [];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xfffdfdfd),
        appBar: AppBar(
          backgroundColor: Color(0xfffdfdfd),
          elevation: 0,
          centerTitle: true,
          title: Row(
            children: [
              Text(
                widget.trip.departureLocationName,
                style: TextStyle(fontSize: 14, color: Colors.green),
              ),
              Icon(
                Icons.arrow_right_alt,
                color: Colors.red,
              ),
              Text(widget.trip.arrivalLocationName,
                  style: TextStyle(fontSize: 14, color: Color(0xff62020a))),
            ],
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
                width: 20,
                height: 25,
                child: Image.asset(
                  'assets/images/back_arrow.png',
                )),
          ),
        ),
        body: tickets.isEmpty
            ? const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    'No tickets',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFE4191D),
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : ListView.builder(
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
                            return const Loading();
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
              ),
      ),
    );
  }
}
