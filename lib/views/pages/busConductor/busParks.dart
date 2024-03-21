import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/destination/destination.dart';
import 'package:bus_stop_develop_admin/models/parksLocations.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/destinations/park_locations_map_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BusParkLocationsConductor extends StatefulWidget {
  final BusCompany company;
  final Destination destination;

  const BusParkLocationsConductor(
      {super.key, required this.company, required this.destination});

  @override
  State<BusParkLocationsConductor> createState() => _BusParkLocationsState();
}

class _BusParkLocationsState extends State<BusParkLocationsConductor> {
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
            widget.destination.name.toUpperCase(),
            style: TextStyle(color: Colors.red[900]),
          )),
      body: StreamBuilder(
        stream: getBusCompanyDestinations(
            companyId: widget.company.uid,
            destinationId: widget.destination.id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            if (kDebugMode) {
              print(snapshot.error);
            }
          }
          if (snapshot.hasData) {
            List<ParkLocations>? data = snapshot.data;
            if (data!.isEmpty) {
              return const Center(
                child: Text(
                  "No Destination Yet!",
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, int index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BusParkLocationsMapView(
                                  company: widget.company,
                                  data: data[index],
                                )));
                      },
                      leading: const Icon(Icons.arrow_right_sharp),
                      title: Text(data[index].parkLocationName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("(" +
                              data[index].positionLat.toString() +
                              " , " +
                              data[index].positionLng.toString() +
                              ")")
                        ],
                      ),
                    );
                  }),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
