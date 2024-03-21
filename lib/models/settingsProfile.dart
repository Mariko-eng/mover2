import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileSettings {
  String email1;
  String email2;
  String phone1;
  String phone2;
  String hotline1;
  String hotline2;

  ProfileSettings(
      {required this.email1,
      required this.email2,
      required this.phone1,
      required this.phone2,
      required this.hotline1,
      required this.hotline2});

  factory ProfileSettings.fromSnap(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map;
    return ProfileSettings(
      email1: data["email1"],
      email2: data["email2"],
      phone1: data["phone1"],
      phone2: data["phone2"],
      hotline1: data["hotline1"],
      hotline2: data["hotline2"],
    );
  }
}

Future<ProfileSettings?> profileSettings() async {
  try {
    var result = await FirebaseFirestore.instance
        .collection("appSettings")
        .doc("bus_stop")
        .get();
    return ProfileSettings.fromSnap(result);
  } catch (e) {
    return null;
  }
}

Future<bool> updateProfile({
  required String email1,
  required String email2,
  required String phone1,
  required String phone2,
  required String hotline1,
  required String hotline2,
}) async {
  try {
    await FirebaseFirestore.instance
        .collection("appSettings")
        .doc("bus_stop")
        .update({
      "email1": email1,
      "email2": email2,
      "phone1": phone1,
      "phone2": phone2,
      "hotline1": hotline1,
      "hotline2": hotline2,
    });
    return true;
  } catch (e) {
    return false;
  }
}
