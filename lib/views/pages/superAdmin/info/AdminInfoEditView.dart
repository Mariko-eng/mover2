import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bus_stop_develop_admin/models/info.dart';

class AdminInfoEditView extends StatefulWidget {
  final InfoModel infoModel;

  const AdminInfoEditView({super.key, required this.infoModel});

  @override
  State<AdminInfoEditView> createState() => _AdminInfoEditViewState();
}

class _AdminInfoEditViewState extends State<AdminInfoEditView> {
  File? _image;
  final _picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();

  final titleCtr = TextEditingController();
  final subTitleCtr = TextEditingController();
  final descCtr = TextEditingController();

  bool isSaving = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      titleCtr.text = widget.infoModel.title;
      subTitleCtr.text = widget.infoModel.subTitle;
      descCtr.text = widget.infoModel.description;
    });
  }

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
          "Edit Article",
          style: TextStyle(color: Colors.red[900]),
        ),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  _showActionDialog(infoModel: widget.infoModel);
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red[900],
                  size: 30,
                ),
              ),
              const SizedBox(
                width: 20,
              )
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
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
                                    validator: (String? val) {
                                      if (val != null) {
                                        if (val.trim().length < 3) {
                                          return "Title Is too short!";
                                        } else {
                                          return null;
                                        }
                                      } else {
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
                                    validator: (String? val) {
                                      if (val != null) {
                                        if (val.trim().length < 3) {
                                          return "Sub title Is too short!";
                                        } else {
                                          return null;
                                        }
                                      } else {
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
                                    validator: (String? val) {
                                      if (val != null) {
                                        if (val.trim().length < 10) {
                                          return "Description Is too short!";
                                        } else {
                                          return null;
                                        }
                                      } else {
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
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: _image == null
                                          ? Container(
                                              height: 100,
                                              width: 100,
                                              child: Image.network(
                                                  widget.infoModel.imageUrl))
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
                      isSaving
                          ? Container(
                              // height: 50,
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  // color: Theme.of(context).primaryColor
                                  ),
                              child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor),
                            )
                          : GestureDetector(
                              onTap: () async {
                                var isValid = _formKey.currentState!.validate();
                                if (isValid) {
                                  try {
                                    setState(() {
                                      isSaving = true;
                                    });
                                    bool res = await editNewInfo(
                                        infoModel: widget.infoModel,
                                        title: titleCtr.text.trim(),
                                        subTitle: subTitleCtr.text.trim(),
                                        image: _image,
                                        description: descCtr.text.trim());

                                    if (res == true) {
                                      Get.snackbar(
                                          "Success", "Edit Successfully!",
                                          colorText: Colors.white,
                                          backgroundColor: Colors.green);
                                      Navigator.of(context).pop();
                                    } else {
                                      Get.snackbar(
                                          "Sorry", "Failed Edit Article!",
                                          colorText: Colors.white,
                                          backgroundColor: Colors.red);
                                    }
                                    setState(() {
                                      isSaving = false;
                                    });
                                  } catch (e) {
                                    Get.snackbar(
                                        "Sorry", "Something Went Wrong!",
                                        colorText: Colors.white,
                                        backgroundColor: Colors.red);
                                    setState(() {
                                      isSaving = false;
                                    });
                                    return;
                                  }
                                }
                              },
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor),
                                child: Text(
                                  "Submit",
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

  void _showActionDialog({required InfoModel infoModel}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(builder: (context) {
                var height = 50.0;
                var width = MediaQuery.of(context).size.width * 0.8;

                return Container(
                  height: height,
                  width: width,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Do You Want To Delete This Item?",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            width: 100,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "NO",
                              style: TextStyle(
                                fontSize: 17,
                                color: Theme.of(context).primaryColor,
                              ),
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          Get.back();
                          await deleteNewInfo(infoModel: infoModel);
                          Get.back();
                        },
                        child: Container(
                            width: 100,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text("Continue",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                ))),
                      ),
                    )
                  ],
                )
              ],
            );
          });
        });
  }
}
