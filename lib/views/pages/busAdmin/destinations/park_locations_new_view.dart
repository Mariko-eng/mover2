import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/destination/destination.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/destinations/park_locations_map_new_view.dart';
import 'package:bus_stop_develop_admin/views/shared/loading.dart';
import 'package:bus_stop_develop_admin/views/shared/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class BusParkLocationsNewView extends StatefulWidget {
  final BusCompany company;
  final Destination destination;

  const BusParkLocationsNewView(
      {Key? key, required this.company, required this.destination})
      : super(key: key);

  @override
  _BusParkLocationsNewViewState createState() =>
      _BusParkLocationsNewViewState();
}

class _BusParkLocationsNewViewState extends State<BusParkLocationsNewView> {
  final _destController = TextEditingController();
  final _destIdController = TextEditingController();
  final _parkNameController = TextEditingController();
  final _coordinatesController = TextEditingController();

  LatLng? parkLocationCoordinates;
  String? parkLocationPlaceId;
  String? parkLocationPlaceName;

  _setLocationDetails(LatLng value, placeId, placeName) {
    setState(() {
      parkLocationCoordinates = value;
      _coordinatesController.text = "(" +
          value.latitude.toString() +
          "  ,  " +
          value.longitude.toString() +
          ")";
      parkLocationPlaceId = placeId;
      parkLocationPlaceName = placeName;
    });
  }

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _destIdController.text = widget.destination.id;
      _destController.text = widget.destination.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: LoadingWidget(),
          )
        : Scaffold(
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.grey[200],
                iconTheme: const IconThemeData(color: Color(0xff62020a)),
                title: Text(
                  widget.destination.name.toUpperCase() +
                      " - " +
                      "New Park Location",
                  style: TextStyle(color: Color(0xff62020a), fontSize: 14),
                )),
            body: FutureBuilder(
              future: getDestinations(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                if (snapshot.hasData) {
                  // List<Destination> destinations = snapshot.data;
                  // print(destinations);
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFieldContainerWidget(
                            child: TextField(
                              controller: _destController,
                              readOnly: true,
                              style: const TextStyle(fontSize: 20),
                              cursorColor: Colors.red,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.location_history_sharp,
                                  color: Color(0xff62020a),
                                ),
                                hintText: "Destination",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          TextFieldContainerWidget(
                            child: TextField(
                              controller: _parkNameController,
                              readOnly: false,
                              style: const TextStyle(fontSize: 20),
                              cursorColor: Colors.red,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.location_history,
                                  color: Color(0xff62020a),
                                ),
                                hintText: "Park Name",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          TextFieldContainerWidget(
                            child: TextField(
                              controller: _coordinatesController,
                              readOnly: true,
                              style: const TextStyle(fontSize: 12),
                              cursorColor: Colors.red,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.location_history_sharp,
                                  color: Color(0xff62020a),
                                ),
                                hintText: "Choose Park Coordinates",
                                border: InputBorder.none,
                              ),
                              onTap: () {
                                Get.to(() => BusParkLocationsMapNew(
                                      company: widget.company,
                                      getCoordinates: _setLocationDetails,
                                    ));
                                // showMap(context);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: GestureDetector(
                              onTap: () async {
                                if (_destController.text.isEmpty) {
                                  Get.snackbar(
                                      "Failed", "Select Destination Location",
                                      colorText: Colors.white,
                                      backgroundColor: Colors.purpleAccent);
                                } else if (_parkNameController.text.isEmpty) {
                                  Get.snackbar(
                                      "Failed", "Enter Park Name",
                                      colorText: Colors.white,
                                      backgroundColor: Colors.purpleAccent);
                                } else if (parkLocationCoordinates == null) {
                                  Get.snackbar(
                                      "Failed", "Select Park Coordinates",
                                      colorText: Colors.white,
                                      backgroundColor: Colors.purpleAccent);
                                } else {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  bool result = await addCompanyParks(
                                      companyId: widget.company.uid,
                                      destinationId: _destIdController.text,
                                      destinationName: _destController.text,
                                      parkLocationName:
                                          _parkNameController.text.trim(),
                                      positionLat:
                                          parkLocationCoordinates!.latitude,
                                      positionLng:
                                          parkLocationCoordinates!.longitude,
                                      placeId: parkLocationPlaceId!,
                                      placeName: parkLocationPlaceName!);
                                  if (result == false) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Get.snackbar(
                                        "Failed To Added Destination/Park",
                                        "Try Again",
                                        colorText: Colors.white,
                                        backgroundColor: Colors.purpleAccent);
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Get.back();
                                    Get.snackbar(
                                        "Success", "Added Destination/Park",
                                        colorText: Colors.white,
                                        backgroundColor: Colors.greenAccent);
                                  }
                                }
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 62,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff62020a),
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: const Text(
                                    "Add Destination/Park",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ));
  }
}
