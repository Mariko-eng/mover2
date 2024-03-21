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

Future<bool> addNewInfo({
  required String title,
  required String subTitle,
  required File image,
  required String description,
}) async {
  try {
    // String imageUrl = await uploadImage(image: image);

    String? fileName = await uploadFile(image: image);

    if(fileName == null ){
      String imageUrl = await getDownloadURL(fileName!);

      var data = {
        "title": title,
        "subTitle": subTitle,
        "imageUrl": imageUrl,
        "description": description,
      };

      await AppCollections.infoRef.add(data);
      return true;
    } else{
      return false;
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

// Future<String> uploadImage({
//   required File image,
// }) async {
//   FirebaseStorage storage = FirebaseStorage.instance;
//
//   try {
//     final fileName = image.path;
//     final destination = 'files/$fileName';
//
//     final ref = storage.ref(destination).child('file/');
//     TaskSnapshot task = await ref.putFile(image);
//     String imageUrl = await task.ref.getDownloadURL();
//
//     return imageUrl;
//   } catch (e) {
//     throw Exception(e.toString());
//   }
// }

Future<String?> uploadFile({
  required File image,
}) async {
  try {
    FirebaseStorage storage = FirebaseStorage.instance;
    const String folderName = "info";
    final fileName = image.path;
    // final destination = 'files/$fileName${DateTime.now().toIso8601String()}';
    final destination = '$folderName/$fileName${DateTime.now().toIso8601String()}';

    // final ref = storage.ref(destination).child('file/');
    final ref = storage.ref().child(destination); // Specify the folder using child method

    // Upload the file to Firebase Storage
    await ref.putFile(image);

    print("Finished Uploading!");
    print("Ref name : " + ref.name);
    print("Ref bucket : " + ref.bucket);
    print("Ref fullPath : " + ref.fullPath);
    print("fileName" + fileName);

    return fileName;
  } catch (e) {
    print("Upload Error : " + e.toString());
    return null;
    // throw Exception(e.toString());
  }
}

Future<String> getDownloadURL(String fileName) async {
  try {
    return await FirebaseStorage.instance
        .ref()
        .child(fileName)
        .getDownloadURL();
  } catch (e) {
    return "";
  }
}