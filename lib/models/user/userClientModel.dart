import 'package:bus_stop_develop_admin/config/collections/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserClientModel{
  String uid;
  String email;
  String phone;
  String name;

  UserClientModel({
    required this.uid,
    required this.email,
    required this.phone,
    required this.name,
});

  factory UserClientModel.fromSnapShot(DocumentSnapshot snapshot){
    Map data = snapshot.data() as Map;
    return UserClientModel(
      uid: snapshot.id,
      name: data["username"],
      email: data["email"],
      phone: data["phoneNumber"]
    );
  }
}

Stream<List<UserClientModel>> getAllClients() {
  return AppCollections.clientsRef
      .snapshots()
      .map((snap) {
        return snap.docs.map((doc) => UserClientModel.fromSnapShot(doc)).toList();
  });
}