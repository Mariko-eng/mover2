import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Location{
  final double lat;
  final double lng;

  Location({ required this.lat, required this.lng});

  factory Location.fromJson(Map<dynamic,dynamic> parsedJson){
    return Location(lat: parsedJson['lat'], lng: parsedJson['lng']);
  }
}

class Geometry{
  final Location location;

  Geometry({ required this.location});

  factory Geometry.fromJson(Map<dynamic,dynamic> parsedJson){
    return Geometry(
        location: Location.fromJson(parsedJson['location']));
  }
}

class Place{
  final Geometry geometry;
  final String name;
  final String vicinity;

  Place({ required this.geometry, required this.name, required this.vicinity});

  factory Place.fromJson(Map<String, dynamic> parsedJson){
    return Place(
        geometry: Geometry.fromJson(parsedJson['geometry']),
        name: parsedJson['formatted_address'],
        vicinity: parsedJson['vicinity']
    );
  }
}

class PlacesService {
  var key = "AIzaSyCFrgs8XmPhssP4bMmfyDyrQxcPE7oiQlo";

  Future<Place> getPlace(String placeID) async {
    try{
      var url =
          "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeID&key=$key";
      var response = await http.post(Uri.parse(url));

      var json = convert.jsonDecode(response.body);
      var jsonResults = json["result"] as Map<String, dynamic>;
      return Place.fromJson(jsonResults);
    }catch(e){
      print(e.toString());
      // return null;
      throw Exception(e.toString());
    }
  }

  Future<Map> getPlaceByCoordinates(double lat, double lng) async {
    var url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$key";

    try{
      var response = await http.post(Uri.parse(url));
      var json = convert.jsonDecode(response.body);
      Map data = {
        "address": json["results"][0]['formatted_address'],
        "place_id": json["results"][0]['place_id']
      };
      return data;
    }catch(e){
      return {};
    }
  }

}
