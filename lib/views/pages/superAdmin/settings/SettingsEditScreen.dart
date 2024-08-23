import 'package:bus_stop_develop_admin/models/settingsProfile.dart';
import 'package:bus_stop_develop_admin/views/widgets/loading.dart';
import 'package:bus_stop_develop_admin/views/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class SettingsEditScreen extends StatefulWidget {
  final ProfileSettings settings;
  const SettingsEditScreen({Key? key,required this.settings}) : super(key: key);

  @override
  _SettingsEditScreenState createState() => _SettingsEditScreenState();
}

class _SettingsEditScreenState extends State<SettingsEditScreen> {
  final _email1Controller = TextEditingController();
  final _email2Controller = TextEditingController();
  final _phone1Controller = TextEditingController();
  final _phone2Controller = TextEditingController();
  final _hotLine1Controller = TextEditingController();
  final _hotLine2Controller = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _email1Controller.text = widget.settings.email1;
    _email2Controller.text = widget.settings.email2;
    _phone1Controller.text = widget.settings.phone1;
    _phone2Controller.text = widget.settings.phone2;
    _hotLine1Controller.text = widget.settings.hotline1;
    _hotLine2Controller.text = widget.settings.hotline2;

  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
      body: LoadingWidget(),
    )
        : Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[200],
          iconTheme: const IconThemeData(color: Color(0xff62020a)),
          title: Text(
            "Edit Company Profile Settings".toUpperCase(),
            style: const TextStyle(
              fontSize: 15,
                color: Color(0xff62020a)),
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
                    controller: _email1Controller,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: 18),
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.people_outline,
                        color: Color(0xff62020a),
                      ),
                      labelText: "Contact Email (1)",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextFieldContainerWidget(
                  child: TextField(
                    controller: _email2Controller,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: 18),
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.people_outline,
                        color: Color(0xff62020a),
                      ),
                      labelText: "Contact Email (2)",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextFieldContainerWidget(
                  child: TextField(
                    controller: _phone1Controller,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(fontSize: 18),
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.people_outline,
                        color: Color(0xff62020a),
                      ),
                      labelText: "Contact Phone (1)",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextFieldContainerWidget(
                  child: TextField(
                    controller: _phone2Controller,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(fontSize: 18),
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.people_outline,
                        color: Color(0xff62020a),
                      ),
                      hintText: "Contact Phone (2)",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextFieldContainerWidget(
                  child: TextField(
                    controller: _hotLine1Controller,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(fontSize: 18),
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.people_outline,
                        color: Color(0xff62020a),
                      ),
                      labelText: "HotLine (1)",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextFieldContainerWidget(
                  child: TextField(
                    controller: _hotLine2Controller,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(fontSize: 18),
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.people_outline,
                        color: Color(0xff62020a),
                      ),
                      labelText: "HotLine (2)",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 10),
                  child: GestureDetector(
                    onTap: () async{

                        // setState(() {
                        //   isLoading = true;
                        // });
                        //
                        //
                        //
                        // print("Done");
                        // setState(() {
                        //   isLoading = false;
                        // });

                        // bool result = await createSuperBusAdminAccount(
                        //   name: _nameController.text.trim(),
                        //   contactEmail: _contactEmailController.text.trim(),
                        //   accountEmail: _accountEmailController.text.trim(),
                        //   phone: _phoneController.text.trim(),
                        //   hotLine: _phoneHotLineController.text.trim(),
                        // );
                        // if (result == false) {
                        //   setState(() {
                        //     isLoading = false;
                        //   });
                        //   Get.snackbar(
                        //       "Failed To Added Admin Account", "Try Again",
                        //       backgroundColor: Colors.purpleAccent);
                        // } else {
                        //   setState(() {
                        //     isLoading = false;
                        //   });
                        //   Get.back();
                        //   Get.snackbar("Success", "Added Admin Account",
                        //       backgroundColor: Colors.greenAccent);
                        // }
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 62,
                        decoration: BoxDecoration(
                            color: Colors.green[700],
                            borderRadius:
                            BorderRadius.circular(20.0)),
                        child: const Text(
                          "UPDATE",
                          style: TextStyle(
                              fontSize: 20, color: Colors.white),
                        )),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}

