import 'package:bus_stop_develop_admin/models/ticket.dart';
import 'package:bus_stop_develop_admin/models/trip.dart';
import 'package:bus_stop_develop_admin/models/user/user.dart';
import 'package:flutter/material.dart';

class TicketReAssign extends StatefulWidget {
  final AdminUserModel user;
  final TripTicket tripTicket;
  const TicketReAssign({Key? key,required this.user,required this.tripTicket}) : super(key: key);

  @override
  _TicketReAssignState createState() => _TicketReAssignState();
}

class _TicketReAssignState extends State<TicketReAssign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Trip To Re-Assign"),
      ),
      body: StreamBuilder(
          stream: getActiveTripsForBusCompany(companyId: widget.user.uid),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            if (snapshot.hasData) {
              List<Trip>? trips = snapshot.data;
              if (trips!.isEmpty) {
                return Center(
                  child: Text(
                    "No Available Trips!".toUpperCase(),
                    style: const TextStyle(color: Color(0xff62020a)),
                  ),
                );
              }
              return ListView.builder(
                  itemCount: trips.length,
                  itemBuilder: (context, int index) => FutureBuilder(
                    future: trips[index].setCompanyData(context),
                    // ignore: missing_return
                    builder: (context, snapshot) {
                      Trip? trip = snapshot.data;
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          if (index == 0) {
                            return Container();
                          }
                          return Container();
                        case ConnectionState.none:
                          return Container();
                        case ConnectionState.active:
                          return Text('Searching... ');
                        case ConnectionState.done:
                          return trip == null
                              ? Container()
                              : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Card(
                              child: ListTile(
                                onTap: () {

                                },
                                leading: Text(
                                    trip.price.toString() + " SHS"),
                                title: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(
                                            width: 50,
                                            child: Text("From :",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color:
                                                    Colors.red))),
                                        Text(trip.departureLocationName),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                            width: 50,
                                            child: const Text("To :",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color:
                                                    Colors.red))),
                                        Text(trip.arrivalLocationName),
                                      ],
                                    )
                                  ],
                                ),
                                trailing:
                                Text(trip.tripType.toString()),
                              ),
                            ),
                          );
                      }
                    },
                  ));
            }
            return Container();
          }),
    );
  }
}
