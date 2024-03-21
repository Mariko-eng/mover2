import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSc extends StatefulWidget {
  const MapSc({required Key key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapSc> {

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    tilt: 30,
    target: LatLng(0.3476, 32.5825),
    zoom: 15.4746,
  );

  LatLng startLocation = LatLng(0.3476, 32.5825);

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  LayoutBuilder(
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
                        draggable: true,
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
