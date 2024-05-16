import 'dart:io';
import 'package:bus_stop_develop_admin/services/cloud_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:firebase_storage/firebase_storage.dart';
import 'package:bus_stop_develop_admin/config/collections/index.dart';

class InfoModel {
  final String id;
  final String title;
  final String subTitle;
  final String imageUrl;
  final String description;
  final String busCompanyId;
  final String busCompanyName;

  InfoModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.imageUrl,
    required this.description,
    required this.busCompanyId,
    required this.busCompanyName,
  });

  factory InfoModel.fromSnapshot(DocumentSnapshot snap) {
    Map data = snap.data() as Map;
    return InfoModel(
      id: snap.id,
      title: data["title"] ?? "",
      subTitle: data["subTitle"] ?? "",
      imageUrl: data["imageUrl"] ?? "",
      description: data["description"] ?? "",
      busCompanyId: data["busCompanyId"] ?? "",
      busCompanyName: data["busCompanyName"] ?? "",
    );
  }
}

Stream<List<InfoModel>> getAllInfo() {
  return AppCollections.infoRef.snapshots().map((snap) {
    return snap.docs.map((doc) => InfoModel.fromSnapshot(doc)).toList();
  });
}

Future<bool> addNewInfo({
  required String title,
  required String subTitle,
  required File image,
  required String description,
  required String busCompanyId,
  required String busCompanyName,
}) async {
  try {
    print("Start : Uploading Image");

    Map<String, dynamic> uploadResults =
        await uploadFileToFirebaseStorage(image: image);

    print("Finish : Uploading Image");

    print("Adding To News & Info");

    var data = {
      "title": title,
      "subTitle": subTitle,
      "imageUrl": uploadResults['fileLink'],
      "description": description,
      "busCompanyId": busCompanyId,
      "busCompanyName": busCompanyName
    };

    await AppCollections.infoRef.add(data);
    print("Done!");
    return true;
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<bool> editNewInfo({
  required InfoModel infoModel,
  required String title,
  required String subTitle,
  required String busCompanyId,
  required String busCompanyName,
  File? image,
  required String description,
}) async {
  try {
    await AppCollections.infoRef.doc(infoModel.id).update({
      "title": title,
      "subTitle": subTitle,
      "description": description,
      "busCompanyId": busCompanyId,
      "busCompanyName": busCompanyName
    });

    if (image != null) {
      print("Start : Uploading Image");

      Map<String, dynamic> uploadResults =
          await uploadFileToFirebaseStorage(image: image);

      print("Finish : Uploading Image");

      print("Updating News & Info");

      await AppCollections.infoRef.doc(infoModel.id).update({
        "imageUrl": uploadResults['fileLink'],
      });

      print("Done!");
      return true;
    }
    return false;
  } catch (e) {
    throw Exception(e.toString());
  }
}


Future<bool> deleteNewInfo({
  required InfoModel infoModel,
}) async {
  try {
    await AppCollections.infoRef.doc(infoModel.id).delete();
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}
