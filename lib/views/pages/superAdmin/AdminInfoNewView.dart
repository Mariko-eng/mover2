import 'dart:io';
import 'package:bus_stop_develop_admin/models/info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminInfoNewView extends StatefulWidget {
  const AdminInfoNewView({super.key});

  @override
  State<AdminInfoNewView> createState() => _AdminInfoNewViewState();
}

class _AdminInfoNewViewState extends State<AdminInfoNewView> {
  File? _image;
  final _picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();

  final titleCtr = TextEditingController();
  final subTitleCtr = TextEditingController();
  final descCtr = TextEditingController();

  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xfffdfdfd),
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
                width: 20,
                height: 25,
                child: Image.asset(
                  'assets/images/back_arrow.png',
                )),
          ),
          title: Text(
            "News & Info",
            style: TextStyle(color: Colors.red[900]),
          )),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New Article Form",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            // border: Border.all(),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          children: [
                            Row(
                              children: [Text("Title")],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: titleCtr,
                                    minLines: 1,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        border: OutlineInputBorder()),
                                    validator: (String? val){
                                      if(val != null){
                                        if(val.trim().length < 3){
                                          return "Title Is too short!";
                                        }else{
                                          return null;
                                        }
                                      }else{
                                        return "Title Is required!";
                                      }
                                    },
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            // border: Border.all(),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          children: [
                            Row(
                              children: [Text("Sub Title")],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: subTitleCtr,
                                    minLines: 1,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        border: OutlineInputBorder()),
                                    validator: (String? val){
                                      if(val != null){
                                        if(val.trim().length < 3){
                                          return "Sub title Is too short!";
                                        }else{
                                          return null;
                                        }
                                      }else{
                                        return "Sub title Is required!";
                                      }
                                    },
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            // border: Border.all(),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          children: [
                            Row(
                              children: [Text("Description")],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: descCtr,
                                    minLines: 3,
                                    maxLines: 10,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        border: OutlineInputBorder()),
                                    validator: (String? val){
                                      if(val != null){
                                        if(val.trim().length < 10){
                                          return "Description Is too short!";
                                        }else{
                                          return null;
                                        }
                                      }else{
                                        return "Description Is required!";
                                      }
                                    },
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            // border: Border.all(),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          children: [
                            Row(
                              children: [Text("Image")],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      _showPicker(context);
                                    },
                                    child: Container(
                                      height: 100,
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius: BorderRadius.circular(5)),
                                      child: _image == null
                                          ? Icon(Icons.photo)
                                          : Container(
                                              height: 100,
                                              width: 100,
                                              child: Image.file(_image!),
                                            ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      isSaving ? Container(
                        // height: 50,
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            // color: Theme.of(context).primaryColor
                        ),
                        child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor
                        ),
                      ) :
                      GestureDetector(
                        onTap: () async{
                          var isValid = _formKey.currentState!.validate();
                          if(isValid){
                            if(_image == null){
                              Get.snackbar("Sorry",
                                  "Select Image For Article",
                                  colorText: Colors.white,
                                  backgroundColor:
                                  Colors.red);
                              return;
                            }else{
                              print("here 123");
                              try{
                                setState(() {
                                  isSaving = true;
                                });
                                 bool res = await addNewInfo(
                                    title: titleCtr.text.trim(),
                                    subTitle: subTitleCtr.text.trim(),
                                    image: _image!,
                                    description: descCtr.text.trim());

                                 if (res == true){
                                   Get.snackbar("Success",
                                       "Added Successfully!",
                                       colorText: Colors.white,
                                       backgroundColor:
                                       Colors.green);
                                   Get.back();
                                 }else{
                                   setState(() {
                                     isSaving = false;
                                   });
                                   Get.snackbar("Sorry",
                                       "Failed Add Article!",
                                       colorText: Colors.white,
                                       backgroundColor:
                                       Colors.red);
                                 }
                              }catch(e){
                                Get.snackbar("Sorry",
                                    "Something Went Wrong!",
                                    colorText: Colors.white,
                                    backgroundColor:
                                    Colors.red);
                                setState(() {
                                  isSaving = false;
                                });
                                return;
                              }
                            }
                          }
                        },
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor
                          ),
                          child: Text("Submit",
                          style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              color: Colors.white,
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
        Get.snackbar("Failed", "No image selected.",
            colorText: Colors.white, backgroundColor: Colors.orange);
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
        Get.snackbar("Failed", "No image selected.",
            colorText: Colors.white, backgroundColor: Colors.orange);
      }
    });
  }
}
