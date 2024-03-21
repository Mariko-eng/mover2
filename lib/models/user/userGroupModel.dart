import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bus_stop_develop_admin/config/collections/index.dart';

final CollectionReference groupsCollection = AppCollections.groupsRef;

class UserGroupModel {
  String id;
  String name;
  String desc;

  UserGroupModel(
      {
        required this.id,
        required this.name,
        required this.desc
      });

  factory UserGroupModel.fromSnapshot(DocumentSnapshot snap) {
    Map data = snap.data() as Map;
    return UserGroupModel(
      id: snap.id,
      name: data["name"] ?? "",
      desc: data["desc"] ?? "",
    );
  }
}

Future<List<UserGroupModel>> getUserGroups() async {
  try {
    QuerySnapshot querySnapshot = await groupsCollection.get();
    List<UserGroupModel> data = querySnapshot.docs.map((doc) => UserGroupModel.fromSnapshot(doc)).toList();
    return data;
  } catch (e) {
    print(e.toString());
    throw Exception(e.toString());
  }
}
