import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

Future<Map<String, dynamic>> uploadFileToFirebaseStorage(
    {required File image}) async {
  String url =
      "https://us-central1-straeto-2c817.cloudfunctions.net/busStopApi/utils/upload/";

  try {
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.headers['Content-Type'] = 'multipart/form-data';

    request.files.add(http.MultipartFile(
      'file',
      image.readAsBytes().asStream(),
      image.lengthSync(),
      filename: 'filename.${image.path.split('.').last}',
      contentType: MediaType('image', image.path.split('.').last),
    ));

    http.StreamedResponse response = await request.send();

    String result = await response.stream.bytesToString();

    var jsonResults = jsonDecode(result);

    // print(jsonResults);
    // {status: Successfully, fileLink: https://firebasestorage.googleapis.com/v0/b/straeto-2c817.appspot.com/o/sdk-files%2Fbcd4687a-0b40-43fc-bf25-1a408255d6dd?alt=media&token=bcd46}

    return jsonResults;
  } catch (_) {
    print(_.toString());
    throw 'Something Went Wrong';
  }
}
