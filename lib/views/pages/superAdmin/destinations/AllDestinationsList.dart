import 'package:bus_stop_develop_admin/models/destination/destination.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/destinations/AllDestiantionsViewEdit.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/destinations/AllDestinationsNew.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AllDestinationsList extends StatefulWidget {
  const AllDestinationsList({Key? key}) : super(key: key);

  @override
  _DestinationListState createState() => _DestinationListState();
}

class _DestinationListState extends State<AllDestinationsList> {
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
            "All Destinations".toUpperCase(),
            style: TextStyle(color: Colors.red[900]),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red[900],
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AllDestinationsNew()));
          },
          child: Icon(Icons.add_box,color: Colors.white,)),
      body: StreamBuilder(
        stream: getAllDestinations(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            if (kDebugMode) {
              print(snapshot.error);
            }
          }
          if (snapshot.hasData) {
            List<Destination>? data = snapshot.data;
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, int index) {
                    return ListTile(
                      onTap: () {
                        _openBottomSheet(destination: data[index]);
                      },
                      leading: const Icon(Icons.arrow_right_sharp),
                      title: Text(data[index].name),
                      subtitle: Text(
                        data[index].locationDetails!.formattedAddress +
                            ", (${data[index].locationDetails!.geometry!.location.lat.toString()}, "
                                "${data[index].locationDetails!.geometry!.location.lng.toString()})",
                        style: TextStyle(fontSize: 12),
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

  void _openBottomSheet({required Destination destination}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return _getDestOptions(destination: destination);
        });
  }

  Widget _getDestOptions({required Destination destination}) {
    final options = [
      "View Bus Trips",
      "View/Edit Destination",
    ];
    return Container(
      height: 250,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: options
            .map((option) => ListTile(
                  onTap: () => {
                    if (option == "View Bus Trips")
                      {
                        Navigator.of(context).pop(),
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => BusCompanyTrips(
                        //           company: company,
                        //         )
                        //     ))
                      },
                    if (option == "View/Edit Destination")
                      {
                        Navigator.of(context).pop(),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllDestinationsViewEdit(
                                      destination: destination,
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
