import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bus_stop_develop_admin/config/google_maps/google_maps.dart';
import 'package:bus_stop_develop_admin/models/destination/destination.dart';
import 'package:bus_stop_develop_admin/models/destination/locationModel.dart';

Future<LocationModel?> getCoordinatesForDestinations(
    {required String destName}) async {
  const apiKey = googleApiKey;
  try {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$destName&key=$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        LocationModel locationModel = LocationModel.fromJson(data);

        // print(locationModel.results[0].toJson());
        // await updateDestinationLocationDetails(
        //     destId: destination.id, locationDetails: locationModel.results[0].toJson());
        return locationModel;
      } else {
        print("Destination Not Found! : " + destName);
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    print(e.toString());
    return null;
  }
}

Future<bool> updateCoordinatesForAllDestinations() async {
  const apiKey = googleApiKey;
  try {
    List<Destination> destinations = await getDestinations();

    for (Destination destination in destinations) {
      String city = destination.name;
      final response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?address=$city&key=$apiKey'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          LocationModel locationModel = LocationModel.fromJson(data);

          print("City Found! : " + city);
          print(locationModel.results[0].formattedAddress);

          print(locationModel.results[0].toJson());

          await updateDestinationLocationDetails(
              destId: destination.id,
              locationDetails: locationModel.results[0].toJson());
        } else {
          print("City Not Found! : " + city);
          await deleteDestination(destId: destination.id);
        }
      }
    }
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}
