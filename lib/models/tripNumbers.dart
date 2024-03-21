import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bus_stop_develop_admin/config/collections/index.dart';

final CollectionReference tripsCollection =
    AppCollections.tripsRef;

class TripNumbers {
  final String tripId;
  final String tripNumber;
  final String arrivalLocationName;
  final String departureLocationName;

  TripNumbers({
    required this.tripId,
    required this.tripNumber,
    required this.arrivalLocationName,
    required this.departureLocationName,
  });

  factory TripNumbers.fromSnapshot(DocumentSnapshot snap) {
    Map data = snap.data() as Map;
    return TripNumbers(
      tripId: snap.id,
      tripNumber: data["tripNumber"],
      arrivalLocationName: data["arrivalLocationName"],
      departureLocationName: data["departureLocationName"],
    );
  }
}

Future<List<TripNumbers>> getAllTripsNumbersForBusCompany(
    {required String companyId}) async {
  DateTime now = DateTime.now();
  DateTime yesterday =
      DateTime(now.year, now.month, now.day - 1, now.hour, now.minute);
  var results = await tripsCollection
      .where('companyId', isEqualTo: companyId)
      .where('departureTime', isGreaterThanOrEqualTo: yesterday)
      .orderBy('departureTime')
      .get();
  return results.docs.map((doc) => TripNumbers.fromSnapshot(doc)).toList();
}
