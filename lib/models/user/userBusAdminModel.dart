import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/user/user.dart';
import 'package:bus_stop_develop_admin/models/user/userGroupModel.dart';
import 'package:bus_stop_develop_admin/services/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:bus_stop_develop_admin/config/collections/index.dart';

final CollectionReference adminAccountsCollection =
    AppCollections.adminAccountsRef;

final CollectionReference companiesCollection = AppCollections.companiesRef;

class BusCompanyUserModel {
  String uid;
  String companyId;
  String group;
  String name;
  String phoneNumber;
  String email;
  String password;

  BusCompanyUserModel({
    required this.uid,
    required this.companyId,
    required this.group,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });

  factory BusCompanyUserModel.fromSnapshot(DocumentSnapshot snap) {
    Map data = snap.data() as Map;
    return BusCompanyUserModel(
      uid: snap.id,
      companyId: data["companyId"] ?? snap.id,
      group: data["group"] ?? "Nan",
      name: data["name"] ?? "",
      phoneNumber: data["phoneNumber"] ?? "",
      email: data["email"] ?? "",
      password: data["password"] ?? "",
    );
  }
}

Stream<List<BusCompanyUserModel>> getAllBusCompanyUserAccounts() {
  return adminAccountsCollection
      // .where("group",isEqualTo: "bus_admin")
      .where("group", isNotEqualTo: "super_bus_admin")
      .snapshots()
      .map((snap) {
    return snap.docs
        .map((doc) => BusCompanyUserModel.fromSnapshot(doc))
        .toList();
  });
}

Stream<List<BusCompanyUserModel>> getSingleBusCompanyUserAccounts(
    {required BusCompany company}) {
  return adminAccountsCollection
      // .where("group",isEqualTo: "bus_admin")
      .where("group", isNotEqualTo: "super_bus_admin")
      .where("companyId", isEqualTo: company.uid)
      .snapshots()
      .map((snap) {
    return snap.docs
        .map((doc) => BusCompanyUserModel.fromSnapshot(doc))
        .toList();
  });
}

// Future<bool> createBusAdminAccount({
//   required BusCompany busCompany,
//   required UserGroupModel group,
//   required String username,
//   required String phoneNumber,
//   required String email,
//   required String password,
// }) async {
//   AdminUserModel? exists = await checkIfUserExistsByEmail(email);
//   // bool exists =  await checkIfUserExists(email);
//   if (exists != null) {
//     throw "Account Already Exists!";
//   }
//
//   bool isRegistered = await isEmailAlreadyRegistered(email);
//
//   if (isRegistered == true) {
//     throw "Account Already Exists!";
//     // throw Exception("Account Already Exists!");
//   }
//
//   FirebaseApp busApp = await Firebase.initializeApp(
//       name: 'bus', options: Firebase.app().options);
//   FirebaseAuth authCreateNewAccount = FirebaseAuth.instanceFor(app: busApp);
//   try {
//     UserCredential result = await authCreateNewAccount
//         .createUserWithEmailAndPassword(email: email, password: password);
//
//     if (result.user != null) {
//       await adminAccountsCollection.doc(result.user!.uid).set({
//         "companyId": busCompany.uid,
//         "company": busCompany.toMap(),
//         "groupId": group.id,
//         "group": group.name,
//         // "group": "bus_admin",
//         "groupDesc": group.desc,
//         "name": username,
//         "phoneNumber": phoneNumber,
//         "email": email,
//         "password": password,
//         "isActive": true,
//         "isMainAccount": false,
//       });
//     }
//     await busApp.delete();
//     return true;
//   } catch (e) {
//     String err = e.toString();
//     if (kDebugMode) {
//       print(err);
//     }
//     await busApp.delete();
//     return false;
//   }
// }
//
// Future<bool> editBusAdminAccount({
//   required String accountId,
//   required UserGroupModel group,
//   required String username,
//   required String phoneNumber,
// }) async {
//   try {
//     await adminAccountsCollection.doc(accountId).update({
//       "groupId": group.id,
//       "group": group.name,
//       "groupDesc": group.desc,
//       "name": username,
//       "phoneNumber": phoneNumber,
//     });
//
//     return true;
//   } catch (e) {
//     print(e.toString());
//     return false;
//   }
// }
//
//
// Future deleteBusCompanyUserAccount(
//     {required BusCompanyUserModel busAdminModel}) async {
//   FirebaseApp busApp = await Firebase.initializeApp(
//       name: 'busCompany', options: Firebase.app().options);
//   FirebaseAuth authCourierApp = FirebaseAuth.instanceFor(app: busApp);
//   try {
//     UserCredential result = await authCourierApp.signInWithEmailAndPassword(
//         email: busAdminModel.email, password: busAdminModel.password);
//
//     await adminAccountsCollection.doc(result.user!.uid).delete();
//     await result.user!.delete();
//     await busApp.delete();
//     return "Success";
//   } catch (e) {
//     String err = e.toString();
//     print("Error");
//     print(err);
//     await busApp.delete();
//     return null;
//   }
// }
