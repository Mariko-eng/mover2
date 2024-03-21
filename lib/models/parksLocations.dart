class ParkLocations {
  String destinationId;
  String destinationName;
  String parkLocationName;
  double positionLat;
  double positionLng;

  ParkLocations({
    required this.destinationId,
    required this.destinationName,
    required this.parkLocationName,
    required this.positionLat,
    required this.positionLng,
  });

  factory ParkLocations.fromMap(Map<String, dynamic> data) {
    return ParkLocations(
        destinationId: data["destinationId"],
        destinationName: data["destinationName"],
        parkLocationName: data["parkLocationName"],
        positionLat: data["positionLat"].toDouble(),
        positionLng: data["positionLng"].toDouble());
  }
}
