// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:bus_stop_develop_admin/models/busCompany.dart';
// import 'package:random_string/random_string.dart';
// import 'package:bus_stop_develop_admin/views/shared/loading.dart';
// import 'package:email_validator/email_validator.dart';
// import 'package:bus_stop_develop_admin/views/shared/text_field_widget.dart';
// import 'package:bus_stop_develop_admin/models/userBusAdminModel.dart';
// import 'package:bus_stop_develop_admin/models/userGroupModel.dart';
//
// class BusCompanyUserAccountsNew extends StatefulWidget {
//   final BusCompany company;
//
//   const BusCompanyUserAccountsNew({Key? key, required this.company})
//       : super(key: key);
//
//   @override
//   State<BusCompanyUserAccountsNew> createState() =>
//       _BusCompanyUserAccountsNewState();
// }
//
// class _BusCompanyUserAccountsNewState extends State<BusCompanyUserAccountsNew> {
//   final _groupController = TextEditingController();
//   final _usernameController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _accountEmailController = TextEditingController();
//   final _accountPasswordController = TextEditingController();
//
//   UserGroupModel? selectedGroup;
//   bool isLoading = false;
//
//   void _generatePassword() {
//     String pass = "bustop_";
//     String randomCode = randomNumeric(6);
//     String password = pass + randomCode;
//     setState(() {
//       _accountPasswordController.text = password;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _generatePassword();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.grey[200],
//           iconTheme: const IconThemeData(color: Color(0xff62020a)),
//           centerTitle: true,
//           title: const Text(
//             "Add User Account",
//             style: TextStyle(color: Color(0xff62020a)),
//           ),
//         ),
//         body: FutureBuilder(
//           future: getUserGroups(),
//           builder: (context, snapshot) {
//             if(snapshot.hasError){
//               return const Center(
//                 child: Text("Something Went Wrong!"),
//               );
//             }
//             if(!snapshot.hasData){
//               return const Center(
//                 child: Loading(),
//               );
//             }else{
//               List<UserGroupModel>? groups = snapshot.data;
//               if(groups == null){
//                 return Container();
//               }
//               return SizedBox(
//               width: MediaQuery.of(context).size.width,
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Divider(
//                         color: Colors.red,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [Text(widget.company.name.toUpperCase())],
//                       ),
//                       const Divider(
//                         color: Colors.red,
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: const [
//                           Text("New User Account Details"),
//                         ],
//                       ),
//                       TextFieldContainerWidget(
//                         child: TextField(
//                           controller: _groupController,
//                           keyboardType: TextInputType.name,
//                           style: const TextStyle(fontSize: 20),
//                           cursorColor: Colors.red,
//                           readOnly:  true,
//                           onTap: (){
//                             showOptionsDialog(
//                               context,
//                               groups
//                             );
//                           },
//                           decoration: const InputDecoration(
//                             icon: Icon(
//                               Icons.pending_actions,
//                               color: Color(0xff62020a),
//                             ),
//                             labelText: "Select Role",
//                             labelStyle: TextStyle(fontSize: 14),
//                             border: InputBorder.none,
//                             suffixIcon: Icon(
//                                 Icons.arrow_drop_down,
//                             )
//                           ),
//                         ),
//                       ),
//                       TextFieldContainerWidget(
//                         child: TextField(
//                           controller: _usernameController,
//                           keyboardType: TextInputType.name,
//                           style: const TextStyle(fontSize: 20),
//                           cursorColor: Colors.red,
//                           decoration: const InputDecoration(
//                             icon: Icon(
//                               Icons.person,
//                               color: Color(0xff62020a),
//                             ),
//                             labelText: "Username",
//                             labelStyle: TextStyle(fontSize: 14),
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                       TextFieldContainerWidget(
//                         child: TextField(
//                           controller: _phoneController,
//                           keyboardType: TextInputType.phone,
//                           style: const TextStyle(fontSize: 20),
//                           cursorColor: Colors.red,
//                           decoration: const InputDecoration(
//                             icon: Icon(
//                               Icons.call,
//                               color: Color(0xff62020a),
//                             ),
//                             labelText: "Phone Number",
//                             labelStyle: TextStyle(fontSize: 14),
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                       TextFieldContainerWidget(
//                         child: TextField(
//                           controller: _accountEmailController,
//                           keyboardType: TextInputType.emailAddress,
//                           style: const TextStyle(fontSize: 20),
//                           cursorColor: Colors.red,
//                           decoration: const InputDecoration(
//                             icon: Icon(
//                               Icons.email,
//                               color: Color(0xff62020a),
//                             ),
//                             labelText: "Email",
//                             labelStyle: TextStyle(fontSize: 14),
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                       TextFieldContainerWidget(
//                         child: TextField(
//                           readOnly: true,
//                           controller: _accountPasswordController,
//                           style: const TextStyle(fontSize: 20),
//                           cursorColor: Colors.red,
//                           decoration: const InputDecoration(
//                             icon: Icon(
//                               Icons.password,
//                               color: Color(0xff62020a),
//                             ),
//                             labelText: "Password",
//                             labelStyle: TextStyle(fontSize: 14),
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 10),
//                         child: isLoading
//                             ? Container(
//                                 alignment: Alignment.center,
//                                 height: 62,
//                                 decoration: BoxDecoration(
//                                     color: const Color(0xff62020a),
//                                     borderRadius: BorderRadius.circular(20.0)),
//                                 child: const CircularProgressIndicator(
//                                   color: Colors.white,
//                                   strokeWidth: 2,
//                                 ))
//                             : GestureDetector(
//                                 onTap: () async {
//                                   final bool isValidAccountEmail =
//                                       EmailValidator.validate(
//                                           _accountEmailController.text.trim());
//                                   if (selectedGroup == null){
//                                     Get.snackbar("Failed", "Select a role",
//                                         colorText: Colors.white,
//                                         backgroundColor: Colors.red);
//                                     return;
//                                   }else
//                                   if (_usernameController.text.isEmpty) {
//                                     Get.snackbar("Failed", "Input Company Name",
//                                         colorText: Colors.white,
//                                         backgroundColor: Colors.red);
//                                     return;
//                                   } else if (_phoneController.text.isEmpty) {
//                                     Get.snackbar("Failed",
//                                         "Input Contact Person Phone Number",
//                                         colorText: Colors.white,
//                                         backgroundColor: Colors.red);
//                                     return;
//                                   } else if (!isValidAccountEmail) {
//                                     Get.snackbar(
//                                         "Failed", "Input/Wrong Account Email",
//                                         colorText: Colors.white,
//                                         backgroundColor: Colors.red);
//                                     return;
//                                   } else {
//                                     try {
//                                       setState(() {
//                                         isLoading = true;
//                                       });
//                                       bool result = await addBusAdminAccount(
//                                           busCompany: widget.company,
//                                           group: selectedGroup!,
//                                           username: _usernameController.text.trim(),
//                                           phoneNumber: _phoneController.text.trim(),
//                                           email:
//                                               _accountEmailController.text.trim(),
//                                           password: _accountPasswordController.text
//                                               .trim());
//                                       if (result == false) {
//                                         setState(() {
//                                           isLoading = false;
//                                         });
//                                         Get.snackbar(
//                                             "Error", "Failed To Add User Account!",
//                                             colorText: Colors.white,
//                                             backgroundColor: Colors.red);
//                                       } else {
//                                         setState(() {
//                                           isLoading = false;
//                                         });
//                                         Get.back();
//                                         Get.snackbar("Success", "Added User Account!",
//                                             backgroundColor: Colors.greenAccent);
//                                       }
//                                     } catch (e) {
//                                       setState(() {
//                                         isLoading = false;
//                                       });
//                                       Get.snackbar("Error", e.toString(),
//                                           colorText: Colors.white,
//                                           backgroundColor: Colors.red);
//                                     }
//                                   }
//                                 },
//                                 child: Container(
//                                     alignment: Alignment.center,
//                                     height: 62,
//                                     decoration: BoxDecoration(
//                                         color: const Color(0xff62020a),
//                                         borderRadius: BorderRadius.circular(20.0)),
//                                     child: const Text(
//                                       "Submit",
//                                       style: TextStyle(
//                                           fontSize: 20, color: Colors.white),
//                                     )),
//                               ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//             }
//           }
//         ));
//   }
//
//   Future<void> showOptionsDialog(
//       BuildContext context,
//       List<UserGroupModel> options,) async {
//     List<UserGroupModel> filteredOptions = options.where((model) => model.name != "super_bus_admin").toList();
//
//     String? selected = await showDialog<String>(
//       context: context,
//       builder: (BuildContext context) {
//         return SimpleDialog(
//           title: Text('Select a role'),
//           children: filteredOptions.map((option) {
//             return SimpleDialogOption(
//               onPressed: () {
//                 Navigator.pop(context, option.name);
//               },
//               child: Container(
//                 color: Colors.grey[200],
//                 padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(option.desc.toUpperCase(),
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 18
//                     ),),
//                     Icon(Icons.arrow_right,color: Colors.blue,)
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         );
//       },
//     );
//     if (selected != null) {
//       setState(() {
//         // Finding the first element with the specified name
//         UserGroupModel? foundModel = options.firstWhere((model) => model.name == selected);
//         selectedGroup = foundModel;
//         _groupController.text = foundModel.desc.toUpperCase();
//       });
//     }
//   }
// }
