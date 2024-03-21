import 'package:bus_stop_develop_admin/config/collections/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationsModel{
   String id;
   String clientId;
   String busCompanyId;
   String title;
   String body;
   bool isClientBased;
   DateTime dateCreated;

   NotificationsModel({
     required this.id,
     required this.clientId,
     required this.busCompanyId,
     required this.title,
     required this.body,
     required this.isClientBased,
     required this.dateCreated
   });

   factory NotificationsModel.fromSnapshot(DocumentSnapshot snapshot){
     Map data = snapshot.data() as Map;
     return NotificationsModel(
       id: snapshot.id,
       clientId: data["clientId"],
       busCompanyId: data["busCompanyId"],
       title: data["title"],
       body: data["body"],
       isClientBased: data["isClientBased"],
       dateCreated: data["dateCreated"].toDate(),
     );
   }
}

Future<bool> addClientNotification({
  required String clientId,
  required String busCompanyId,
  required String title,
  required String body,
}) async{
  DateTime nw = DateTime.now();
  try{
    await AppCollections.notificationsRef.add({
      "clientId":clientId,
      "busCompanyId":busCompanyId,
      "title":title,
      "body":body,
      "isClientBased": true,
      "dateCreated": nw
    });
    return true;
  }catch(e){
    return false;
  }

}

Future<bool> addBusCompanyNotification({
  required String busCompanyId,
  required String title,
  required String body,
}) async{
  DateTime nw = DateTime.now();
  try{
    await AppCollections.notificationsRef.add({
      "clientId":"",
      "busCompanyId":busCompanyId,
      "title":title,
      "body":body,
      "isClientBased": false,
      "dateCreated": nw
    });
    return true;
  }catch(e){
    return false;
  }
}

Stream<List<NotificationsModel>> getBusCompanyNotifications({required String companyId}){
  return AppCollections.notificationsRef
      .where('busCompanyId', isEqualTo: companyId)
      .orderBy('dateCreated',descending: true)
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => NotificationsModel.fromSnapshot(doc)).toList();
  });
}
