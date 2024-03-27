import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:bus_stop_develop_admin/config/collections/index.dart';

class InfoModel {
  final String id;
  final String title;
  final String subTitle;
  final String imageUrl;
  final String description;

  InfoModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.imageUrl,
    required this.description,
  });

  factory InfoModel.fromSnapshot(DocumentSnapshot snap) {
    Map data = snap.data() as Map;
    return InfoModel(
      id: snap.id,
      title: data["title"] ?? "",
      subTitle: data["subTitle"] ?? "",
      imageUrl: data["imageUrl"] ?? "",
      description: data["description"] ?? "",
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
}) async {
  try {
    String? fileName = await uploadFile(image: image);

    if (fileName != null) {
      String imageUrl = await getDownloadURL(fileName);

      print("Adding To News & Info");

      if (imageUrl != "") {
        var data = {
          "title": title,
          "subTitle": subTitle,
          "imageUrl": imageUrl,
          "description": description,
        };

        await AppCollections.infoRef.add(data);
        print("Done!");
        return true;
      }
    }
    return false;
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<bool> editNewInfo({
  required InfoModel infoModel,
  required String title,
  required String subTitle,
  File? image,
  required String description,
}) async {
  try {
    await AppCollections.infoRef.doc(infoModel.id).update({
      "title": title,
      "subTitle": subTitle,
      "description": description,
    });

    if (image != null) {
      String? fileName = await uploadFile(image: image);

      if (fileName != null) {
        String imageUrl = await getDownloadURL(fileName);

        print("Updating News & Info");

        if (imageUrl != "") {
          await AppCollections.infoRef.doc(infoModel.id).update({
            "imageUrl": imageUrl,
          });

          print("Done!");
          return true;
        }
      }
    } else {
      return true;
    }
    return false;
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<String?> uploadFile({
  required File image,
}) async {
  try {
    FirebaseStorage storage = FirebaseStorage.instance;
    const String folderName = "info";
    final fileName = image.path;
    // final destination = 'files/$fileName${DateTime.now().toIso8601String()}';
    final destination =
        '$folderName/${DateTime.now().toIso8601String()}$fileName';
    print("destination");
    print(destination);

    // final ref = storage.ref(destination).child('file/');
    final ref = storage
        .ref()
        .child(destination); // Specify the folder using child method
    // final ref = storage.ref(destination); // Specify the folder using child method
    // Upload the file to Firebase Storage
    await ref.putFile(image);

    print("Finished Uploading!");
    // print("Ref name : " + ref.name);
    // print("Ref bucket : " + ref.bucket);
    // print("Ref fullPath : " + ref.fullPath);
    // print("fileName" + fileName);

    // return fileName;
    return destination;
  } catch (e) {
    print("Upload Error : " + e.toString());
    return null;
    // throw Exception(e.toString());
  }
}

Future<String> getDownloadURL(String fileName) async {
  print("fileName" + fileName);

  try {
    return await FirebaseStorage.instance
        .ref()
        .child(fileName)
        .getDownloadURL();
  } catch (e) {
    return "";
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
