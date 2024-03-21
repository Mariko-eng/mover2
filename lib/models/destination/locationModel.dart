class LocationModel {
  List<LocationDetailsModel> results;
  String status;

  LocationModel({
    required this.results,
    required this.status,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    results: List<LocationDetailsModel>.from(
        json["results"].map((x) => LocationDetailsModel.fromJson(x))),
    status: json["status"],
  );
}

class LocationDetailsModel {
  List<AddressComponent> addressComponents;
  String formattedAddress;
  Geometry? geometry;
  String placeId;
  List<String> types;

  LocationDetailsModel({
    required this.addressComponents,
    required this.formattedAddress,
    this.geometry,
    required this.placeId,
    required this.types,
  });

  factory LocationDetailsModel.fromJson(Map<String, dynamic> json) =>
      LocationDetailsModel(
        addressComponents: json["address_components"] == null ? [] : List<AddressComponent>.from(json["address_components"].map((x) => AddressComponent.fromJson(x))),
        formattedAddress: json["formatted_address"] ?? "",
        geometry: json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
        placeId: json["place_id"] ?? "",
        types: json["types"] == null ? [] : List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
    "address_components": List<dynamic>.from(addressComponents.map((x) => x.toJson())),
    "formatted_address": formattedAddress,
    "geometry": geometry?.toJson(),
    "place_id": placeId,
    "types": List<dynamic>.from(types.map((x) => x)),
  };
}

class AddressComponent {
  String longName;
  String shortName;
  List<String> types;

  AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      AddressComponent(
        longName: json["long_name"] ?? "",
        shortName: json["short_name"] ?? "",
        types: json["types"] == null ? [] : List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
    "long_name": longName,
    "short_name": shortName,
    "types": List<dynamic>.from(types.map((x) => x)),
  };
}

class Geometry {
  String locationType;
  Location location;
  // Bounds? bounds;
  // Bounds? viewport;

  Geometry({
    required this.locationType,
    required this.location,
    // this.bounds,
    // this.viewport,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    locationType: json["location_type"] ?? "",
    location: Location.fromJson(json["location"]),
    // bounds: Bounds.fromJson(json["bounds"]),
    // viewport: Bounds.fromJson(json["viewport"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location.toJson(),
    "location_type": locationType,
    // "bounds": bounds.toJson(),
    // "viewport": viewport.toJson(),
  };
}

// class Bounds {
//   Location northeast;
//   Location southwest;
//
//   Bounds({
//     required this.northeast,
//     required this.southwest,
//   });
//
//   factory Bounds.fromJson(Map<String, dynamic> json) => Bounds(
//         northeast: Location.fromJson(json["northeast"]),
//         southwest: Location.fromJson(json["southwest"]),
//       );
// }

class Location {
  double lat;
  double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}
