import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';
import 'package:bus_stop_develop_admin/models/user/userSuperAdminModel.dart';

class SuperAdminUserAccountsEditView extends StatefulWidget {
  final SuperAdminUserModel adminUserModel;

  const SuperAdminUserAccountsEditView({super.key, required this.adminUserModel});

  @override
  State<SuperAdminUserAccountsEditView> createState() =>
      _SuperAdminUserAccountsEditViewState();
}

class _SuperAdminUserAccountsEditViewState
    extends State<SuperAdminUserAccountsEditView> {
  final _nameController = TextEditingController();
  final _contactEmailController = TextEditingController();
  final _accountEmailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _phoneHotLineController = TextEditingController();

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    setState(() {
      _nameController.text = widget.adminUserModel.name;
      _contactEmailController.text = widget.adminUserModel.contactEmail;
      _accountEmailController.text = widget.adminUserModel.email;
      _phoneController.text = widget.adminUserModel.phoneNumber;
      _phoneHotLineController.text = widget.adminUserModel.hotLine;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[200],
          iconTheme: const IconThemeData(color: Color(0xff62020a)),
          title: Text(
            "Edit Super Admin Account".toUpperCase(),
            style: const TextStyle(fontSize: 15, color: Color(0xff62020a)),
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
                          children: [Text("Username")],
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
                                      return "Username Is Required/ It is too short!";
                                    } else {
                                      return null;
                                    }
                                  } else {
                                    return "Username Is Required/ It is too short!";
                                  }
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        // border: Border.all(),
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      children: [
                        Row(
                          children: [Text("Phone Number")],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _phoneController,
                                minLines: 1,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    border: OutlineInputBorder()),
                                validator: (String? val) {
                                  if (val != null) {
                                    if (val.trim().length < 10) {
                                      return "Phone Is Required/ It is Invalid!";
                                    } else {
                                      return null;
                                    }
                                  } else {
                                    return "Phone Is Required/ It is Invalid!";
                                  }
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        // border: Border.all(),
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      children: [
                        Row(
                          children: [Text("Hotline Number")],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _phoneHotLineController,
                                minLines: 1,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    border: OutlineInputBorder()),
                                validator: (String? val) {
                                  return null;
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        // border: Border.all(),
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      children: [
                        Row(
                          children: [Text("Contact Email")],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _contactEmailController,
                                minLines: 1,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    border: OutlineInputBorder()),
                                validator: (String? val) {
                                  if (val != null) {
                                    final bool isValidEmail =
                                        EmailValidator.validate(val.trim());
                                    if (!isValidEmail) {
                                      return "Email Is Required/ It is invalid!";
                                    } else {
                                      return null;
                                    }
                                  } else {
                                    return "Email Is Required/ It is invalid!";
                                  }
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        // border: Border.all(),
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      children: [
                        Row(
                          children: [Text("Email")],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _accountEmailController,
                                minLines: 1,
                                maxLines: 1,
                                readOnly: true,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    border: OutlineInputBorder()),
                                validator: (String? val) {
                                  if (val != null) {
                                    final bool isValidEmail =
                                        EmailValidator.validate(val.trim());
                                    if (!isValidEmail) {
                                      return "Email Is Required/ It is invalid!";
                                    } else {
                                      return null;
                                    }
                                  } else {
                                    return "Email Is Required/ It is invalid!";
                                  }
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  isLoading
                      ? Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(),
                          child: const CircularProgressIndicator(
                            color: Color(0xff62020a),
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
                                bool? result = await editSuperBusAdminAccount(
                                  accountId: widget.adminUserModel.uid,
                                  name: _nameController.text.trim(),
                                  contactEmail:
                                      _contactEmailController.text.trim(),
                                  phone: _phoneController.text.trim(),
                                  hotLine: _phoneHotLineController.text.trim(),
                                );
                                if (result == false) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Get.snackbar("Failed To Added Admin Account",
                                      "Try Again",
                                      backgroundColor: Colors.red);
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Get.back();
                                  Get.snackbar("Success", "Added Admin Account",
                                      backgroundColor: Colors.greenAccent);
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
                                  "Edit",
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
}
