import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bus_stop_develop_admin/config/collections/index.dart';
import 'package:bus_stop_develop_admin/models/destination/locationModel.dart';

class Destination {
  final String id;
  final String name;
  final LocationDetailsModel? locationDetails;

  Destination({required this.id, required this.name, this.locationDetails});

  factory Destination.fromSnapshot(DocumentSnapshot snap) {
    Map data = snap.data() as Map;
    return Destination(
        id: snap.id,
        name: data["name"] ?? "",
        locationDetails: data["locationDetails"] == null
            ? null
            : LocationDetailsModel.fromJson(data["locationDetails"]));
  }
}

Future getDestinations() async {
  var results = await AppCollections.destinationsRef.get();
  return results.docs.map((doc) => Destination.fromSnapshot(doc)).toList();
}

Stream<List<Destination>> getAllDestinations() {
  return AppCollections.destinationsRef.snapshots().map((snap) {
    return snap.docs.map((doc) => Destination.fromSnapshot(doc)).toList();
  });
}

Future<bool> addDestinations({required String name, required Map locationDetails}) async {
  try {
    var results = await AppCollections.destinationsRef.get();
    List<Destination> dests =
        results.docs.map((doc) => Destination.fromSnapshot(doc)).toList();
    for (int i = 0; i < dests.length; i++) {
      if (name.trim() == dests[i].name.trim()) {
        return false;
      }
    }
    await AppCollections.destinationsRef.add({
      "name": name,
      "locationDetails" : locationDetails
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> updateDestination(
    {required String destId, required String name}) async {
  try {
    await AppCollections.destinationsRef.doc(destId).update({
      "name": name,
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> updateDestinationLocationDetails(
    {required String destId, required Map locationDetails}) async {
  try {
    await AppCollections.destinationsRef.doc(destId).update({
      "locationDetails": locationDetails,
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> deleteDestination({required String destId}) async {
  try {
    await AppCollections.destinationsRef.doc(destId).delete();
    return true;
  } catch (e) {
    return false;
  }
}
