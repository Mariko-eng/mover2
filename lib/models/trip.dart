import 'package:bus_stop_develop_admin/config/collections/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'Notifications.dart';

final CollectionReference tripsCollection = AppCollections.tripsRef;
final CollectionReference ticketsCollection = AppCollections.ticketsRef;
final CollectionReference destinationsCollection =
    AppCollections.destinationsRef;
final CollectionReference companiesCollection = AppCollections.companiesRef;

class Trip {
  final String id;
  // final DocumentReference arrivalLocation;
  final String arrivalLocationId;
  final String arrivalLocationName;
  // final DocumentReference departureLocation;
  final String departureLocationId;
  final String departureLocationName;
  final String companyId;
  final DocumentReference company;
  final String busPlateNo;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final int totalSeats;
  final int occupiedSeats;
  final int price;
  final int discountPrice;
  final int totalOrdinarySeats;
  final int occupiedOrdinarySeats;
  final int priceOrdinary;
  final int discountPriceOrdinary;
  final int totalVipSeats;
  final int occupiedVipSeats;
  final int priceVip;
  final int discountPriceVip;
  final String tripNumber;
  final String tripType;
  Map<String, dynamic>? companyData;

  // Map<String, dynamic> arrival;
  // Map<String, dynamic> departure;

  Trip(
      {required this.id,
      required this.arrivalLocationId,
      required this.arrivalLocationName,
      required this.departureLocationId,
      required this.departureLocationName,
      required this.company,
      required this.companyId,
        required  this.busPlateNo,
      required this.departureTime,
      required this.arrivalTime,
      required this.totalSeats,
      required this.occupiedSeats,
      required this.price,
      required this.discountPrice,
      required this.totalOrdinarySeats,
      required this.occupiedOrdinarySeats,
      required this.priceOrdinary,
      required this.discountPriceOrdinary,
      required this.totalVipSeats,
      required this.occupiedVipSeats,
      required this.priceVip,
      required this.discountPriceVip,
      required this.tripNumber,
      required this.tripType});

  Future<Trip> setCompanyData(BuildContext context) async {
    DocumentSnapshot companySnapshot = await company.get();
    Map<String, dynamic> companyMap =
        companySnapshot.data() as Map<String, dynamic>;
    companyData = {'id': companySnapshot.id}..addAll(companyMap);
    return this;
  }

  factory Trip.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map;

    return Trip(
        id: snapshot.id,
        arrivalLocationId: data['arrivalLocationId'] ?? "",
        arrivalLocationName: data['arrivalLocationName'] ?? "",
        departureLocationId: data['departureLocationId'] ?? "",
        departureLocationName: data['departureLocationName'] ?? "",
        company: data['company'],
        companyId: data['companyId'] ?? "",
        busPlateNo: data['busPlateNo'] ?? "",
        departureTime: data['departureTime'].toDate(),
        arrivalTime: data['arrivalTime'].toDate(),
        totalSeats: data['totalSeats'] ?? 0,
        occupiedSeats: data['occupiedSeats'] ?? 0,
        price: data['price'] ?? 0,
        discountPrice: data['discountPrice'] ?? data['price'],
        totalOrdinarySeats: data['totalOrdinarySeats'] ?? 0,
        occupiedOrdinarySeats: data['occupiedOrdinarySeats'] ?? 0,
        priceOrdinary: data['priceOrdinary'] ?? 0,
        discountPriceOrdinary:
            data['discountPriceOrdinary'] ?? data['priceOrdinary'] ?? 0,
        totalVipSeats: data['totalVipSeats'] ?? 0,
        occupiedVipSeats: data['occupiedVipSeats'] ?? 0,
        priceVip: data['priceVip'] ?? 0,
        discountPriceVip: data['discountPriceVip'] ?? data['priceVip'] ?? 0,
        tripNumber: data['tripNumber'],
        tripType: data['tripType'] ?? "");
  }
}

Future<String> getRandomNumber() async {
  String num1 = randomNumeric(4);
  String num2 = randomNumeric(4);
  String num = "T" + num1 + num2;
  try {
    var res = await tripsCollection.where("tripNumber", isEqualTo: num).get();
    if (res.docs.isEmpty) {
      return num;
    } else {
      return getRandomNumber();
    }
  } catch (e) {
    print("Error While Checking For Ticket Number");
    return num;
  }
}

Future addTripOrdinaryOnly(
    {required String arrivalLocationName,
    required String arrivalLocationId,
    required String departureLocationId,
    required String departureLocationName,
    required String companyId,
    required String companyName,
    required DateTime departureTime,
    required DateTime arrivalTime,
    required String busPlateNo,
    required int totalSeats,
    int occupiedSeats = 0,
    required int price,
    required int discountPrice,
    required int totalOrdinarySeats,
    int occupiedOrdinarySeats = 0,
    required int priceOrdinary,
    required int discountPriceOrdinary,
    int totalVipSeats = 0,
    int occupiedVipSeats = 0,
    required int priceVip,
    required int discountPriceVip,
    required String tripType}) async {
  try {
    DocumentReference arrivalLocation =
        destinationsCollection.doc(arrivalLocationId);

    DocumentReference departureLocation =
        destinationsCollection.doc(departureLocationId);

    DocumentReference company = companiesCollection.doc(companyId);

    String num = await getRandomNumber();

    await tripsCollection.add({
      "arrivalLocation": arrivalLocation,
      "arrivalLocationId": arrivalLocationId,
      "arrivalLocationName": arrivalLocationName,
      "departureLocation": departureLocation,
      "departureLocationId": departureLocationId,
      "departureLocationName": departureLocationName,
      "company": company,
      "companyId": companyId,
      "companyName": companyName,
      "departureTime": departureTime,
      "arrivalTime": arrivalTime,
      "busPlateNo": busPlateNo,
      "totalSeats": totalSeats,
      "occupiedSeats": occupiedSeats,
      "price": price,
      "discountPrice": discountPrice,
      "totalOrdinarySeats": totalOrdinarySeats,
      "occupiedOrdinarySeats": occupiedOrdinarySeats,
      "priceOrdinary": priceOrdinary,
      "discountPriceOrdinary": discountPriceOrdinary,
      "totalVipSeats": totalVipSeats,
      "occupiedVipSeats": occupiedVipSeats,
      "priceVip": priceVip,
      "discountPriceVip": discountPriceVip,
      "tripType": tripType,
      'tripNumber': num,
      'is_active': true
    });
    await addBusCompanyNotification(
        busCompanyId: companyId,
        title: "New Trip",
        body: departureLocationName.toUpperCase() +
            " To " +
            arrivalLocationName.toUpperCase());
    return "success";
  } catch (e) {
    print(e);
    return null;
  }
}

Future addTripOrdinaryAndVIP(
    {required String arrivalLocationName,
    required String arrivalLocationId,
    required String departureLocationId,
    required String departureLocationName,
    required String companyId,
    required String companyName,
    required DateTime departureTime,
    required DateTime arrivalTime,
    required String busPlateNo,
    required int totalSeats,
    int occupiedSeats = 0,
    required int totalOrdinarySeats,
    int occupiedOrdinarySeats = 0,
    required int totalVipSeats,
    int occupiedVipSeats = 0,
    required int price,
    required int discountPrice,
    required int priceVip,
    required int discountPriceVip,
    required int priceOrdinary,
    required int discountPriceOrdinary,
    required String tripType}) async {
  try {
    DocumentReference arrivalLocation =
        destinationsCollection.doc(arrivalLocationId);

    DocumentReference departureLocation =
        destinationsCollection.doc(departureLocationId);

    DocumentReference company = companiesCollection.doc(companyId);

    String num = await getRandomNumber();

    await tripsCollection.add({
      "arrivalLocation": arrivalLocation,
      "arrivalLocationId": arrivalLocationId,
      "arrivalLocationName": arrivalLocationName,
      "departureLocation": departureLocation,
      "departureLocationId": departureLocationId,
      "departureLocationName": departureLocationName,
      "company": company,
      "companyId": companyId,
      "companyName": companyName,
      "departureTime": departureTime,
      "arrivalTime": arrivalTime,
      "busPlateNo": busPlateNo,
      "totalSeats": totalSeats,
      "occupiedSeats": occupiedSeats,
      "price": price,
      "discountPrice": discountPrice,
      "totalOrdinarySeats": totalOrdinarySeats,
      "occupiedOrdinarySeats": occupiedOrdinarySeats,
      "priceOrdinary": priceOrdinary,
      "discountPriceOrdinary": discountPriceOrdinary,
      "totalVipSeats": totalVipSeats,
      "occupiedVipSeats": occupiedVipSeats,
      "priceVip": priceVip,
      "discountPriceVip": discountPriceVip,
      "tripType": tripType,
      'tripNumber': num,
      'is_active': true
    });
    return "success";
  } catch (e) {
    print(e);
    return null;
  }
}

// Future updateTrip(
//     {String tripId,
//     String arrivalLocationId,
//     String departureLocationId,
//     String companyId,
//     DateTime departureTime,
//     DateTime arrivalTime,
//     int totalSeats,
//     int occupiedSeats = 0,
//     int price,
//     String tripType}) async {
//   try {
//     DocumentSnapshot docArrival = await FirebaseFirestore.instance
//         .collection("destinations")
//         .doc(arrivalLocationId)
//         .get();
//     DocumentReference arrivalLocation = docArrival.reference;
//
//     DocumentSnapshot docDeparture = await FirebaseFirestore.instance
//         .collection("destinations")
//         .doc(departureLocationId)
//         .get();
//     DocumentReference departureLocation = docDeparture.reference;
//
//     DocumentSnapshot docCompany = await FirebaseFirestore.instance
//         .collection("companies")
//         .doc(companyId)
//         .get();
//     DocumentReference company = docCompany.reference;
//
//     await FirebaseFirestore.instance.collection('trips').doc(tripId).update({
//       "arrivalLocation": arrivalLocation,
//       "arrivalLocationId": arrivalLocationId,
//       "departureLocation": departureLocation,
//       "departureLocationId": departureLocationId,
//       "company": company,
//       "companyId": companyId,
//       "departureTime": departureTime,
//       "arrivalTime": arrivalTime,
//       "totalSeats": totalSeats,
//       "occupiedSeats": occupiedSeats,
//       "price": price,
//       "tripType": tripType,
//       "isActive": true
//     });
//   } catch (e) {
//     print(e);
//   }
// }

Future<bool> deleteTrip({
  required String tripId,
}) async {
  try {
    await tripsCollection.doc(tripId).delete();

    DocumentReference _ref = tripsCollection.doc(tripId);
    var results = await ticketsCollection.where("trip", isEqualTo: _ref).get();

    for (int i = 0; i < results.docs.length; i++) {
      await ticketsCollection.doc(results.docs[i].id).delete();
    }

    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Stream<List<Trip>> getActiveTripsForBusCompany({required String companyId}) {
  DateTime now = DateTime.now();
  DateTime yesterday =
      DateTime(now.year, now.month, now.day - 1, now.hour, now.minute);

  return tripsCollection
      .where('departureTime', isGreaterThanOrEqualTo: yesterday)
      .where('companyId', isEqualTo: companyId)
      .orderBy('departureTime')
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => Trip.fromSnapshot(doc)).toList();
  });
}

Stream<List<Trip>> getNonActiveTripsForBusCompany({required String companyId}) {
  DateTime now = DateTime.now();
  DateTime yesterday =
      DateTime(now.year, now.month, now.day - 1, now.hour, now.minute);

  return tripsCollection
      .where('departureTime', isLessThanOrEqualTo: yesterday)
      .where('companyId', isEqualTo: companyId)
      .orderBy('departureTime')
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => Trip.fromSnapshot(doc)).toList();
  });
}

Stream<List<Trip>> getAllTripsForBusCompany({required String companyId}) {
  return tripsCollection
      .where('companyId', isEqualTo: companyId)
      .orderBy('departureTime')
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => Trip.fromSnapshot(doc)).toList();
  });
}

Stream<List<Trip>> get activeTrips {
  DateTime now = DateTime.now();
  DateTime yesterday =
      DateTime(now.year, now.month, now.day - 1, now.hour, now.minute);

  return tripsCollection
      .where('departureTime', isGreaterThanOrEqualTo: yesterday)
      .orderBy('departureTime')
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => Trip.fromSnapshot(doc)).toList();
  });
}

Stream<List<Trip>> get allTrips {
  return tripsCollection.orderBy('departureTime').snapshots().map((snap) {
    return snap.docs.map((doc) => Trip.fromSnapshot(doc)).toList();
  });
}

Stream<List<Trip>> getReportTrips({required DateTime date}) {
  final startDate = DateTime(date.year, date.month, date.day);
  final endDate = DateTime(date.year, date.month, date.day + 1);

  return tripsCollection
      .where('departureTime',
          isGreaterThanOrEqualTo: startDate, isLessThanOrEqualTo: endDate)
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => Trip.fromSnapshot(doc)).toList();
  });
}

Stream<List<Trip>> getReportTripsForBusCompany(
    {required DateTime date, required String companyId}) {
  final startDate = DateTime(date.year, date.month, date.day);
  final endDate = DateTime(date.year, date.month, date.day + 1);

  return tripsCollection
      .where('departureTime', isEqualTo: companyId)
      .where('date',
          isGreaterThanOrEqualTo: startDate, isLessThanOrEqualTo: endDate)
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => Trip.fromSnapshot(doc)).toList();
  });
}
