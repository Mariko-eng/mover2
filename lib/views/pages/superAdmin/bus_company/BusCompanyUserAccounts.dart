// import 'package:bus_stop_develop_admin/models/userBusAdminModel.dart';
// import 'package:bus_stop_develop_admin/views/pages/superAdmin/bus_company/BusCompanyUserAccountsNew.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:bus_stop_develop_admin/models/busCompany.dart';
//
// class BusCompanyUserAccountsList extends StatefulWidget {
//   final BusCompany company;
//
//   const BusCompanyUserAccountsList({Key? key, required this.company})
//       : super(key: key);
//
//   @override
//   State<BusCompanyUserAccountsList> createState() =>
//       _BusCompanyUserAccountsListState();
// }
//
// class _BusCompanyUserAccountsListState
//     extends State<BusCompanyUserAccountsList> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: const Color(0xfffdfdfd),
//           elevation: 0,
//           leading: GestureDetector(
//             onTap: () {
//               Navigator.of(context).pop();
//             },
//             child: SizedBox(
//                 width: 20,
//                 height: 25,
//                 child: Image.asset(
//                   'assets/images/back_arrow.png',
//                 )),
//           ),
//           centerTitle: true,
//           title: Text(
//             widget.company.name.toUpperCase(),
//             style: TextStyle(color: Colors.red[900]),
//           )),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//       floatingActionButton: FloatingActionButton(
//           backgroundColor: Colors.red[900],
//           onPressed: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         BusCompanyUserAccountsNew(company: widget.company)));
//           },
//           child: const Icon(
//             Icons.add_box,
//             color: Colors.white,
//           )),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.people,
//                   color: Colors.red[900],
//                 ),
//                 const SizedBox(
//                   width: 5,
//                 ),
//                 const Text("List Of User Accounts",
//                 style: TextStyle(
//                   fontWeight: FontWeight.w800
//                 ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 5,),
//             Divider(),
//             SizedBox(height: 5,),
//             StreamBuilder(
//               stream: getSingleBusCompanyUserAccounts(company: widget.company),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   if (kDebugMode) {
//                     print(snapshot.error);
//                   }
//                 }
//                 if (snapshot.hasData) {
//                   List<BusCompanyUserModel>? data = snapshot.data;
//                   if (data == null) {
//                     return const Expanded(
//                         child: Center(
//                       child: Text("No Accounts"),
//                     ));
//                   }
//                   if (data.isEmpty) {
//                     return const Expanded(
//                         child: Center(
//                       child: Text("No Accounts"),
//                     ));
//                   }
//                   return Expanded(
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       child: ListView.builder(
//                           itemCount: data.length,
//                           itemBuilder: (context, int index) {
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 10),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: Colors.grey[100],
//                                     borderRadius: const BorderRadius.only(
//                                       topLeft: Radius.circular(10),
//                                       topRight: Radius.circular(10),
//                                     )),
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                       height: 30,
//                                       decoration: BoxDecoration(
//                                           color: Colors.red[100],
//                                           borderRadius: const BorderRadius.only(
//                                             topLeft: Radius.circular(10),
//                                             topRight: Radius.circular(10),
//                                           )),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.only(left: 10),
//                                             child: Text(
//                                               data[index].group.toUpperCase(),
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyLarge!
//                                                   .copyWith(
//                                                 color: Colors.blue[900],
//                                                   fontWeight:
//                                                   FontWeight.bold),
//                                             ),
//                                           ),
//                                           // Row(
//                                           //   children: [
//                                           //     GestureDetector(
//                                           //       onTap: () {
//                                           //         // _performDeleteCompany(data[index]);
//                                           //       },
//                                           //       child: Icon(
//                                           //         Icons.delete,
//                                           //         color: Colors.red[900],
//                                           //       ),
//                                           //     ),
//                                           //     const SizedBox(
//                                           //       width: 10,
//                                           //     )
//                                           //   ],
//                                           // ),
//                                         ],
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     Column(
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Text(
//                                               "Name : ",
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyLarge!
//                                                   .copyWith(
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                             ),
//                                             const SizedBox(
//                                               width: 10,
//                                             ),
//                                             Text(data[index].name)
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             Text(
//                                               "Email : ",
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyLarge!
//                                                   .copyWith(
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                             ),
//                                             const SizedBox(
//                                               width: 10,
//                                             ),
//                                             Text(data[index].email)
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             Text(
//                                               "Phone Number : ",
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyLarge!
//                                                   .copyWith(
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                             ),
//                                             const SizedBox(
//                                               width: 10,
//                                             ),
//                                             Text(data[index].phoneNumber)
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             Text(
//                                               "Password : ",
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyLarge!
//                                                   .copyWith(
//                                                   fontWeight:
//                                                   FontWeight.bold),
//                                             ),
//                                             const SizedBox(
//                                               width: 10,
//                                             ),
//                                             Text(data[index].password)
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Expanded(
//                                           child: GestureDetector(
//                                             onTap: () {
//                                               // _openBottomSheet(company: data[index]);
//                                             },
//                                             child: Container(
//                                               height: 30,
//                                               alignment: Alignment.center,
//                                               padding: const EdgeInsets.symmetric(
//                                                   horizontal: 10),
//                                               child: Text(
//                                                 "More Actions",
//                                                 style: TextStyle(
//                                                     color: Colors.red[900]),
//                                               ),
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color:
//                                                           Colors.red[900]!),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           10)),
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             );
//                           }),
//                     ),
//                   );
//                 } else {
//                   return Container();
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
