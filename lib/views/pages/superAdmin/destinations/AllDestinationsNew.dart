import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_stop_develop_admin/models/destination/destination.dart';
import 'package:bus_stop_develop_admin/models/destination/locationModel.dart';
import 'package:bus_stop_develop_admin/services/location_service.dart';

class AllDestinationsNew extends StatefulWidget {
  const AllDestinationsNew({Key? key}) : super(key: key);

  @override
  _DestinationNewState createState() => _DestinationNewState();
}

class _DestinationNewState extends State<AllDestinationsNew> {
  final _nameController = TextEditingController();

  bool isLoading = false;

  LocationDetailsModel? selectedLocationDetails;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[200],
          iconTheme: const IconThemeData(color: Color(0xff62020a)),
          title: const Text(
            "Add Destination",
            style: TextStyle(color: Color(0xff62020a)),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
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
                          children: [Text("Name Of Destination")],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _nameController,
                                minLines: 1,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    border: OutlineInputBorder()),
                                validator: (String? val) {
                                  if (val != null) {
                                    if (val.trim().length < 2) {
                                      return "Name Is Required/ It too short!";
                                    } else {
                                      return null;
                                    }
                                  } else {
                                    return "Name Is Required/ It too short!";
                                  }
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  isLoading
                      ? Container(
                          // height: 50,
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(),
                          child: CircularProgressIndicator(
                            color: const Color(0xff62020a),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10),
                          child: GestureDetector(
                            onTap: () async {
                              var isValid = _formKey.currentState!.validate();

                              if (isValid) {
                                setState(() {
                                  isLoading = true;
                                });

                                bool res = await _getCoordinates(
                                    destName: _nameController.text.trim());

                                if (res == true &&
                                    selectedLocationDetails != null) {
                                  bool result = await addDestinations(
                                      name: _nameController.text
                                          .trim()
                                          .toUpperCase(),
                                      locationDetails:
                                          selectedLocationDetails!.toJson());

                                  if (result == false) {
                                    Get.snackbar("Sorry",
                                        "Destination Already Exists / Something Went Wrong!",
                                        colorText: Colors.white,
                                        backgroundColor: Colors.red);
                                  } else {
                                    Get.back();
                                    Get.snackbar("Success", "Added Destination",
                                        colorText: Colors.white,
                                        backgroundColor: Colors.greenAccent);
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Get.snackbar("Sorry",
                                      "Failed To Get Coordinates For The Destination",
                                      colorText: Colors.white,
                                      backgroundColor: Colors.red);
                                }
                              }
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height: 62,
                                decoration: BoxDecoration(
                                    color: const Color(0xff62020a),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: const Text(
                                  "Add Destination",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<bool> _getCoordinates({required String destName}) async {
    LocationModel? res =
        await getCoordinatesForDestinations(destName: destName);

    if (res != null) {
      setState(() {
        selectedLocationDetails = res.results.first;
      });
      return true;
    } else {
      return false;
    }
  }
}
