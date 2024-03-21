import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class ParkLocationsNew extends StatefulWidget {
  const ParkLocationsNew({Key? key}) : super(key: key);

  @override
  _ParkLocationsNewState createState() => _ParkLocationsNewState();
}

class _ParkLocationsNewState extends State<ParkLocationsNew> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    tilt: 30,
    target: LatLng(0.3476, 32.5825),
    zoom: 15.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.red[900]),
        backgroundColor: Colors.grey[200],
        centerTitle: true,
        title: Text(
          "Add Park Location",
          style: TextStyle(
              fontSize: 20,
              color: Colors.red[900]),
        ),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        indoorViewEnabled: true,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
