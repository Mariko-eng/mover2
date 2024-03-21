import 'package:bus_stop_develop_admin/config/collections/index.dart';
import 'package:bus_stop_develop_admin/models/parksLocations.dart';
import 'package:bus_stop_develop_admin/models/user/userBusAdminModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class BusCompany {
  String uid;
  String name;
  String email;
  String phoneNumber;
  String hotLine;
  String logo;

  BusCompany(
      {required this.uid,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.hotLine,
      required this.logo});

  factory BusCompany.fromSnapshot(DocumentSnapshot snap) {
    Map data = snap.data() as Map;
    return BusCompany(
      uid: snap.id,
      name: data["name"] ?? "",
      email: data["email"] ?? "",
      phoneNumber: data["phoneNumber"] ?? "",
      hotLine: data["hotLine"] ?? "",
      logo: data["logo"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'hotLine': hotLine,
      'logo': logo,
    };
  }
}

Stream<List<BusCompany>> getAllBusCompanies() {
  return AppCollections.companiesRef.snapshots().map((snap) {
    return snap.docs.map((doc) => BusCompany.fromSnapshot(doc)).toList();
  });
}

Future<List<BusCompany>> fetchBusCompanies() async{
  try {
    var res = await AppCollections.companiesRef.get();
    return res.docs.map((doc) => BusCompany.fromSnapshot(doc)).toList();
  }catch (e){
    throw e.toString();
  }
}

Future<bool> createBusCompany({
  required String name,
  required String email,
  required String phoneNumber,
  required String hotline,
}) async {
  try {
    QuerySnapshot snap1 =
        await companiesCollection.where("name", isEqualTo: name).get();
    if (snap1.docs.isNotEmpty) {
      throw Exception("Company Name Already Exist!");
    }

    QuerySnapshot snap2 =
        await companiesCollection.where("email", isEqualTo: email).get();
    if (snap2.docs.isNotEmpty) {
      throw Exception("Company Email Already Exist!");
    }

    await companiesCollection.add({
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "hotLine": hotline,
      "logo": "",
      "parks": [],
      "parksLocations": [],
    });
    return true;
  } catch (e) {
    String err = e.toString();
    if (kDebugMode) {
      print(err);
    }
    throw Exception(err);
  }
}

Future<bool> addCompanyParks({
  required String companyId,
  required String destinationId,
  required String destinationName,
  required String parkLocationName,
  required double positionLat,
  required double positionLng,
  required String placeId,
  required String placeName,
}) async {
  try {
    await AppCollections.companiesRef.doc(companyId).update({
      "parksLocations": FieldValue.arrayUnion([
        {
          "destinationId": destinationId,
          "destinationName": destinationName,
          "parkLocationName": parkLocationName,
          "positionLat": positionLat,
          "positionLng": positionLng,
          "placeId": placeId,
          "placeName": placeName,
        }
      ]),
    });
    return true;
  } catch (e) {
    return false;
  }
}

Stream<List<ParkLocations>> getBusCompanyDestinations(
    {required String companyId, required String destinationId}) {
  return AppCollections.companiesRef.doc(companyId).snapshots().map((snap) {
    Map<String, dynamic> data = snap.data() as Map<String, dynamic>;
    var parks = data["parksLocations"] as List;
    List<ParkLocations> _result = [];
    if (parks.isNotEmpty) {
      for (var element in parks) {
        var item = ParkLocations.fromMap(element);
        if (item.destinationId == destinationId) {
          _result.add(item);
        }
      }
    }
    return _result;
  });
}

Future<BusCompany?> getBusCompanyProfile({required String companyId}) async {
  try {
    var result = await AppCollections.companiesRef.doc(companyId).get();
    return BusCompany.fromSnapshot(result);
  } catch (e) {
    return null;
  }
}

Future<bool> deleteBusCompany({required BusCompany company}) async {
  try {
    var res = await AppCollections.adminAccountsRef
        .where("companyId", isEqualTo: company.uid)
        .get();

    List<BusCompanyUserModel> accounts =
        res.docs.map((obj) => BusCompanyUserModel.fromSnapshot(obj)).toList();

    for (var account in accounts) {
      await deleteBusCompanyUserAccount(busAdminModel: account);
    }

    await AppCollections.companiesRef.doc(company.uid).delete();

    DocumentReference companyRef = AppCollections.companiesRef.doc(company.uid);

    var companyTripResults = await AppCollections.tripsRef
        .where("company", isEqualTo: companyRef)
        .get();

    for (int i = 0; i < companyTripResults.docs.length; i++) {
      await AppCollections.tripsRef.doc(companyTripResults.docs[i].id).delete();

      DocumentReference tripRef =
          AppCollections.tripsRef.doc(companyTripResults.docs[i].id);

      var companyTicketResults = await AppCollections.ticketsRef
          .where("trip", isEqualTo: tripRef)
          .get();

      for (int i = 0; i < companyTicketResults.docs.length; i++) {
        await AppCollections.ticketsRef
            .doc(companyTicketResults.docs[i].id)
            .delete();
      }
    }

    return true;
  } catch (e) {
    print(e);
    return false;
  }
}
