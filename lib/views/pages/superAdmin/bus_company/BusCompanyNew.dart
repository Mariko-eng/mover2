import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/views/shared/loading.dart';
import 'package:bus_stop_develop_admin/views/shared/text_field_widget.dart';


class BusCompanyNew extends StatefulWidget {
  const BusCompanyNew({Key? key}) : super(key: key);

  @override
  _NewBusCompanyState createState() => _NewBusCompanyState();
}

class _NewBusCompanyState extends State<BusCompanyNew> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _hotLineController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: Loading(),
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.grey[200],
              iconTheme: const IconThemeData(color: Color(0xff62020a)),
              centerTitle: true,
              title: const Text(
                "Add Bus Company",
                style: TextStyle(color: Color(0xff62020a)),
              ),
            ),
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFieldContainerWidget(
                      child: TextField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        style: const TextStyle(fontSize: 20),
                        cursorColor: Colors.red,
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: Color(0xff62020a),
                          ),
                          labelText: "Company Name",
                          labelStyle: TextStyle(fontSize: 14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    TextFieldContainerWidget(
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(fontSize: 20),
                        cursorColor: Colors.red,
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.alternate_email,
                            color: Color(0xff62020a),
                          ),
                          labelText: "Company Email",
                          labelStyle: TextStyle(fontSize: 14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    TextFieldContainerWidget(
                      child: TextField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(fontSize: 20),
                        cursorColor: Colors.red,
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.call,
                            color: Color(0xff62020a),
                          ),
                          labelText: "Company Phone Number",
                          labelStyle: TextStyle(fontSize: 14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    TextFieldContainerWidget(
                      child: TextField(
                        controller: _hotLineController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(fontSize: 20),
                        cursorColor: Colors.red,
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.phone,
                            color: Color(0xff62020a),
                          ),
                          labelText: "Company HotLine Number",
                          labelStyle: TextStyle(fontSize: 14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: GestureDetector(
                        onTap: () async {
                          final bool isValidEmail =
                              EmailValidator.validate(
                                  _emailController.text.trim());
                          if (_nameController.text.isEmpty) {
                            Get.snackbar("Failed", "Input Company Name",
                                colorText: Colors.white,
                                backgroundColor: Colors.purpleAccent);
                            return;
                          } else if (!isValidEmail) {
                            Get.snackbar(
                                "Failed", "Input/Wrong Company Email",
                                colorText: Colors.white,
                                backgroundColor: Colors.purpleAccent);
                            return;
                          }
                          else if (_phoneNumberController.text.isEmpty) {
                            Get.snackbar(
                                "Failed", "Input Company Phone Number",
                                colorText: Colors.white,
                                backgroundColor: Colors.purpleAccent);
                            return;
                          } else {
                            try{
                              setState(() {
                                isLoading = true;
                              });
                              bool result = await createBusCompany(
                                  name: _nameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  phoneNumber: _phoneNumberController.text.trim(),
                                  hotline: _hotLineController.text.trim());
                              if (result == false) {
                                setState(() {
                                  isLoading = false;
                                });
                                Get.snackbar(
                                    "Error", "Failed To Add Bus Company!",
                                    colorText: Colors.white,
                                    backgroundColor: Colors.red);
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                Get.back();
                                Get.snackbar("Success", "Added Bus Company!",
                                    backgroundColor: Colors.greenAccent);
                              }
                            }catch(e){
                              setState(() {
                                isLoading = false;
                              });
                              Get.snackbar("Error", e.toString(),
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
                                borderRadius: BorderRadius.circular(20.0)),
                            child: const Text(
                              "Submit",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
