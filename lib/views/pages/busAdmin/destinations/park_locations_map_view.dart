import 'dart:async';
import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/parksLocations.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusParkLocationsMapView extends StatefulWidget {
  final BusCompany company;
  final ParkLocations data;
  const BusParkLocationsMapView({Key? key,required this.company,required this.data}) : super(key: key);

  @override
  _BusParkLocationsMapViewState createState() => _BusParkLocationsMapViewState();
}

class _BusParkLocationsMapViewState extends State<BusParkLocationsMapView> {
  final Completer<GoogleMapController> _controller = Completer();

  late CameraPosition _kGooglePlex;

  late LatLng startLocation;

  @override
  void initState() {
    super.initState();
    setState(() {
      startLocation = LatLng(widget.data.positionLat, widget.data.positionLng);
      _kGooglePlex = CameraPosition(
        tilt: 30,
        target: LatLng(widget.data.positionLat, widget.data.positionLng),
        zoom: 15.4746,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.data.destinationName + ", " + widget.data.parkLocationName),
      ),
      body: LayoutBuilder(
        builder: (ctx, constraints) {
          return Column(
            children: [
              Container(
                height: constraints.maxHeight * 1.0,
                width: constraints.maxWidth,
                color: Colors.grey[200],
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: GoogleMap(
                  mapType: MapType.normal,
                  indoorViewEnabled: true,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: <Marker>{
                    Marker(
                      markerId: MarkerId("destination"),
                      infoWindow: InfoWindow(title: "destination"),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueGreen),
                      position: startLocation,
                      // draggable: true,
                    ),
                  },

                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
