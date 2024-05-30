import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bus_stop_develop_admin/config/collections/index.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;


final CollectionReference adminAccountsCollection =
    AppCollections.adminAccountsRef;

class AdminUserModel {
  String uid;
  String name;
  String email;
  String password;
  String contactEmail;
  String phoneNumber;
  String group;
  String companyId;
  bool isActive;
  bool isMainAccount;

  AdminUserModel(
      {required this.uid,
      required this.name,
      required this.email,
      required this.password,
      required this.contactEmail,
      required this.phoneNumber,
      required this.group,
      required this.companyId,
      required this.isActive,
      required this.isMainAccount});

  factory AdminUserModel.fromSnapshot(DocumentSnapshot snap) {
    Map data = snap.data() as Map;
    return AdminUserModel(
      uid: snap.id,
      name: data["name"] ?? "",
      email: data["email"] ?? "",
      password: data["password"] ?? "",
      contactEmail: data["contactEmail"] ?? "",
      phoneNumber: data["phoneNumber"] ?? "",
      group: data["group"] ?? "",
      companyId: data["companyId"] ?? "",
      isActive: data["isActive"] ?? false,
      isMainAccount: data["isMainAccount"] ?? false,
    );
  }

// factory AdminUserModel.fromSnapData(DocumentSnapshot snap){
//   Map data = snap.data() as Map;
//   return AdminUserModel(
//     uid: snap.id,
//     name: data["name"],
//     email: data["email"],
//     contactEmail: data["contactEmail"],
//     phoneNumber: data["phoneNumber"],
//     group: data["group"],
//     isActive: data["isActive"],
//   );
// }
}

Future<AdminUserModel?> getAdminUserProfile({required String uid}) async {
  try {
    DocumentSnapshot snap = await adminAccountsCollection.doc(uid).get();
    return AdminUserModel.fromSnapshot(snap);
  } catch (e) {
    print(e.toString());
    return null;
  }
}

Future<AdminUserModel?> checkIfUserExistsByEmail(String email) async {
  try {
    QuerySnapshot snap =
    await adminAccountsCollection.where("email", isEqualTo: email).get();
    if (snap.docs.isNotEmpty) {
      return AdminUserModel.fromSnapshot(snap.docs.first);
    } else {
      return null;
    }
  } catch (e) {
    print(e.toString());
    return null;
    // throw Exception(e.toString());
  }
}


Future<bool> postAdminData(Map<String, dynamic> data) async {
  try {
    String url = "https://us-central1-straeto-2c817.cloudfunctions.net/busStopApi/auth/admins/?env=${AppCollections().isTestMode ? "dev" : "prod"}";

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      // Successfully updated data
      print('Admin Data Posted: ${response.body}');
      return true;
    } else {
      print(response.body);
      // Error updating data
      print('Failed to post admin data: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('$e');
  }
}

Future<bool> updateAdminData(String userId, Map<String, dynamic> data) async {
  try {
    String url = "https://us-central1-straeto-2c817.cloudfunctions.net/busStopApi/auth/admins/$userId?env=${AppCollections().isTestMode ? "dev" : "prod"}";
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      // Successfully updated data
      print('Admin Data Posted: ${response.body}');
      return true;
    } else {
      print(response.body);
      // Error updating data
      print('Failed to post admin data: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('$e');
  }
}

Future<bool> deleteAdminData(String userId) async {
  try {
    String url = "https://us-central1-straeto-2c817.cloudfunctions.net/busStopApi/auth/admins/$userId?env=${AppCollections().isTestMode ? "dev" : "prod"}";
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Successfully updated data
      print('Data updated: ${response.body}');
      return true;
    } else {
      print(response.body);
      // Error updating data
      print('Failed to update data: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('$e');
  }
}
