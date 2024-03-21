import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/destination/destination.dart';
import 'package:bus_stop_develop_admin/models/parksLocations.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/destinations/park_locations_map_view.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/destinations/park_locations_new_view.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/destinations/park_locations_view_edit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BusParkLocationsListView extends StatefulWidget {
  final BusCompany company;
  final Destination destination;

  const BusParkLocationsListView(
      {Key? key, required this.company, required this.destination})
      : super(key: key);

  @override
  _BusParkLocationsListViewState createState() =>
      _BusParkLocationsListViewState();
}

class _BusParkLocationsListViewState extends State<BusParkLocationsListView> {
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red[900],
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BusParkLocationsNewView(
                          company: widget.company,
                          destination: widget.destination,
                        )));
          },
          child: Icon(
            Icons.add_box,
            color: Colors.white,
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
                        _openBottomSheet(parkLocation: data[index]);
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
            // print("Here2");
            return Container();
          }
        },
      ),
    );
  }

  void _openBottomSheet({required ParkLocations parkLocation}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return _getDestOptions(parkLocation: parkLocation);
        });
  }

  Widget _getDestOptions({required ParkLocations parkLocation}) {
    final options = [
      "Go To Map",
      "View/Edit Destination/Parks",
    ];
    return Container(
      height: 140,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: options
            .map((option) => ListTile(
                  onTap: () => {
                    if (option == "Go To Map")
                      {
                        Navigator.of(context).pop(),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BusParkLocationsMapView(
                                      company: widget.company,
                                      data: parkLocation,
                                    )))
                      },
                    if (option == "View/Edit Destination/Parks")
                      {
                        Navigator.of(context).pop(),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BusParkLocationsViewEdit(
                                      company: widget.company,
                                      destination: widget.destination,
                                      data: parkLocation,
                                    )))
                      },
                  },
                  title: Column(
                    children: [
                      Text(
                        option,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Color(0xFFE4191D)),
                      ),
                      SizedBox(height: 4),
                      Divider(height: 1)
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
