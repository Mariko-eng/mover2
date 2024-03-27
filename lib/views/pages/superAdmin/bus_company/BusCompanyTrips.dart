import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/trip.dart';
import 'package:flutter/material.dart';

class BusCompanyTrips extends StatefulWidget {
  final BusCompany company;

  const BusCompanyTrips({Key? key, required this.company}) : super(key: key);

  @override
  _BusCompanyTripsState createState() => _BusCompanyTripsState();
}

class _BusCompanyTripsState extends State<BusCompanyTrips> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[200],
          iconTheme: IconThemeData(color: const Color(0xff62020a)),
          title: Text(
            widget.company.name + " Trips".toUpperCase(),
            style: TextStyle(color: Color(0xff62020a)),
          )),
      body: StreamBuilder(
        stream: getAllTripsForBusCompany(companyId: widget.company.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.hasData) {
            List<Trip>? trips = snapshot.data;
            if(trips!.isEmpty){
              return Center(
                child: Text("No Available Trips!".toUpperCase(),
                style: const TextStyle(
                  color: Color(0xff62020a)
                ),
                ),
              );
            }
            return ListView.builder(
                itemCount: trips.length,
                itemBuilder: (context, int index) {
                  Trip trip = trips[index];
                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: Card(
                                      child: ListTile(
                                        onTap: () {},
                                        leading: Text(
                                            trip.price.toString() + " SHS"),
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                    width: 50,
                                                    child: const Text("From :",
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
                    );
          }
          return Container();
        },
      ),
    );
  }
}
