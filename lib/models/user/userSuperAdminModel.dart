import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:bus_stop_develop_admin/config/collections/index.dart';

final CollectionReference adminAccountsCollection =
    AppCollections.adminAccountsRef;

class SuperAdminUserModel {
  String uid;
  String name;
  String email;
  String contactEmail;
  String phoneNumber;
  String hotLine;
  String group;
  bool isActive;

  SuperAdminUserModel(
      {required this.uid,
      required this.name,
      required this.email,
      required this.contactEmail,
      required this.phoneNumber,
      required this.hotLine,
      required this.group,
      required this.isActive});

  factory SuperAdminUserModel.fromSnapData(DocumentSnapshot snap) {
    Map data = snap.data() as Map;
    return SuperAdminUserModel(
      uid: snap.id,
      name: data["name"] ?? "",
      email: data["email"] ?? "",
      contactEmail: data["contactEmail"] ?? "",
      phoneNumber: data["phoneNumber"] ?? "",
      hotLine: data["hotLine"] ?? "",
      group: data["group"] ?? "",
      isActive: data["isActive"] ?? false,
    );
  }
}

Stream<List<SuperAdminUserModel>> getAdminAccounts() {
  return adminAccountsCollection
      .where("group", isEqualTo: "super_bus_admin")
      .snapshots()
      .map((snap) {
    return snap.docs
        .map((doc) => SuperAdminUserModel.fromSnapData(doc))
        .toList();
  });
}

Future<bool?> createSuperBusAdminAccount(
    {required String name,
    required String phone,
    required String accountEmail,
    required String contactEmail,
    required String password,
    required String hotLine}) async {
  FirebaseApp superAdminApp = await Firebase.initializeApp(
      name: 'superAdmin', options: Firebase.app().options);
  FirebaseAuth authCreateNewAccount =
      FirebaseAuth.instanceFor(app: superAdminApp);

  try {
    UserCredential result =
        await authCreateNewAccount.createUserWithEmailAndPassword(
            email: accountEmail, password: password);

    if (result.user != null) {
      await adminAccountsCollection.doc(result.user!.uid).set({
        "name": name,
        "email": accountEmail,
        "contactEmail": contactEmail,
        "phoneNumber": phone,
        "hotLine": hotLine,
        "password": password,
        "isActive": true,
        "group": "super_bus_admin"
      });
      await superAdminApp.delete();
      return true;
    }
    return true;
  } catch (e) {
    String err = e.toString();
    if (kDebugMode) {
      print(err);
    }
    await superAdminApp.delete();
    return false;
  }
}

Future<bool?> editSuperBusAdminAccount(
    {required String accountId,
    required String name,
    required String phone,
    required String contactEmail,
    required String hotLine}) async {
  try {
    await adminAccountsCollection.doc(accountId).set({
      "name": name,
      "contactEmail": contactEmail,
      "phoneNumber": phone,
      "hotLine": hotLine,
    });
    return true;
  } catch (e) {
    String err = e.toString();
    if (kDebugMode) {
      print(err);
    }
    return false;
  }
}
