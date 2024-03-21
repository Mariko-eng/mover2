import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/views/shared/loading.dart';
import 'package:email_validator/email_validator.dart';
import 'package:bus_stop_develop_admin/models/user/userBusAdminModel.dart';
import 'package:bus_stop_develop_admin/models/user/userGroupModel.dart';

class BusAdminUserAccountsEditView extends StatefulWidget {
  final BusCompanyUserModel adminUserModel;
  final BusCompany company;

  const BusAdminUserAccountsEditView(
      {super.key, required this.company, required this.adminUserModel});

  @override
  State<BusAdminUserAccountsEditView> createState() =>
      _BusAdminUserAccountsEditViewState();
}

class _BusAdminUserAccountsEditViewState
    extends State<BusAdminUserAccountsEditView> {
  final _groupController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _accountEmailController = TextEditingController();

  UserGroupModel? selectedGroup;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    setState(() {
      _groupController.text = widget.adminUserModel.group;
      _usernameController.text = widget.adminUserModel.name;
      _accountEmailController.text = widget.adminUserModel.email;
      _phoneController.text = widget.adminUserModel.phoneNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[200],
          iconTheme: const IconThemeData(color: Color(0xff62020a)),
          centerTitle: true,
          title: Text(
            "Edit user Account",
            style: TextStyle(color: Color(0xff62020a)),
          ),
        ),
        body: FutureBuilder(
            future: getUserGroups(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Something Went Wrong!"),
                );
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: Loading(),
                );
              } else {
                List<UserGroupModel>? groups = snapshot.data;
                if (groups == null) {
                  return Container();
                }
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                    children: [Text("User Role")],
                                  ),
                                  Divider(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: _groupController,
                                          keyboardType: TextInputType.name,
                                          style: const TextStyle(fontSize: 20),
                                          cursorColor: Colors.red,
                                          readOnly: true,
                                          onTap: () {
                                            showOptionsDialog(context, groups);
                                          },
                                          minLines: 1,
                                          maxLines: 1,
                                          decoration: InputDecoration(
                                              suffixIcon: Icon(
                                                Icons.arrow_drop_down,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              border: OutlineInputBorder()),
                                          validator: (String? val) {
                                            if (val != null) {
                                              if (val.trim().length < 2) {
                                                return "Role Is Required/ It is too short!";
                                              } else {
                                                return null;
                                              }
                                            } else {
                                              return "Role Is Required/ It is too short!";
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
                                    children: [Text("Username")],
                                  ),
                                  Divider(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: _usernameController,
                                          minLines: 1,
                                          maxLines: 1,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
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
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
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
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              border: OutlineInputBorder()),
                                          validator: (String? val) {
                                            if (val != null) {
                                              final bool isValidEmail =
                                                  EmailValidator.validate(
                                                      val.trim());
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
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: isLoading
                                  ? Container(
                                      alignment: Alignment.center,
                                      height: 62,
                                      decoration: BoxDecoration(
                                          color: const Color(0xff62020a),
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ))
                                  : GestureDetector(
                                      onTap: () async {
                                        var isValid =
                                            _formKey.currentState!.validate();

                                        if (isValid) {
                                          try {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            bool result =
                                                await editBusAdminAccount(
                                              // busCompany: widget.company,
                                              accountId: widget.adminUserModel.uid,
                                              group: selectedGroup!,
                                              username: _usernameController.text
                                                  .trim(),
                                              phoneNumber:
                                                  _phoneController.text.trim(),
                                            );
                                            if (result == false) {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              Get.snackbar("Error",
                                                  "Failed To Add User Account!",
                                                  colorText: Colors.white,
                                                  backgroundColor: Colors.red);
                                            } else {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              Get.back();
                                              Get.snackbar("Success",
                                                  "Added User Account!",
                                                  backgroundColor:
                                                      Colors.greenAccent);
                                            }
                                          } catch (e) {
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
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          child: const Text(
                                            "Submit",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          )),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            }));
  }

  Future<void> showOptionsDialog(
    BuildContext context,
    List<UserGroupModel> options,
  ) async {
    List<UserGroupModel> filteredOptions =
        options.where((model) => model.name != "super_bus_admin").toList();

    String? selected = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Select a role'),
          children: filteredOptions.map((option) {
            return SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, option.name);
              },
              child: Container(
                color: Colors.grey[200],
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      option.desc.toUpperCase(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                    Icon(
                      Icons.arrow_right,
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
    if (selected != null) {
      setState(() {
        // Finding the first element with the specified name
        UserGroupModel? foundModel =
            options.firstWhere((model) => model.name == selected);
        selectedGroup = foundModel;
        _groupController.text = foundModel.desc.toUpperCase();
      });
    }
  }
}
