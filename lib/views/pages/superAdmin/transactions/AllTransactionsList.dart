import 'package:bus_stop_develop_admin/models/transaction/transaction.dart';
import 'package:bus_stop_develop_admin/views/shared/loading.dart';
import 'package:bus_stop_develop_admin/views/shared/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SuperAdminAllTransactionsList extends StatefulWidget {
  const SuperAdminAllTransactionsList({super.key});

  @override
  State<SuperAdminAllTransactionsList> createState() =>
      _AllTransactionsListState();
}

class _AllTransactionsListState extends State<SuperAdminAllTransactionsList> {
  List<String> _years = [];
  late String _selectedYear;
  late String _selectedMonth;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    setState(() {
      // Get the current year
      int currentYear = DateTime.now().year;
      int currentMonth = DateTime.now().month;

      // Generate a list of years from 2000 to the current year
      _years = List.generate(
          currentYear - 1999, (index) => (2000 + index).toString());

      // Set the current year as the selected value
      _selectedYear = currentYear.toString();
      _selectedMonth = currentMonth.toString();
      _selectedDate = DateTime(currentYear, currentMonth);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffdfdfd),
      appBar: AppBar(
          backgroundColor: const Color(0xfffdfdfd),
          elevation: 0,
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
          centerTitle: true,
          title: Text(
            "All Transactions".toUpperCase(),
            style: TextStyle(color: Colors.red[900]),
          )),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filter By Date",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownMenu(
                        menuHeight: 300,
                        initialSelection: _selectedYear,
                        // helperText: "Year",
                        dropdownMenuEntries: _years
                            .map((item) =>
                                DropdownMenuEntry(value: item, label: item))
                            .toList(),
                        onSelected: (String? val) {
                          if (val != null) {
                            setState(() {
                              int yearValue = int.parse(val);
                              int monthValue = int.parse(_selectedMonth);
                              _selectedYear = val;
                              _selectedDate = DateTime(yearValue, monthValue);
                              print("_selectedDate : " +
                                  _selectedDate.toString());
                            });
                          }
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      DropdownMenu(
                        menuHeight: 300,
                        initialSelection: _selectedMonth,
                        // helperText: "Month",
                        dropdownMenuEntries: [
                          DropdownMenuEntry(value: "1", label: "Jan"),
                          DropdownMenuEntry(value: "2", label: "Feb"),
                          DropdownMenuEntry(value: "3", label: "Mar"),
                          DropdownMenuEntry(value: "4", label: "Apr"),
                          DropdownMenuEntry(value: "5", label: "May"),
                          DropdownMenuEntry(value: "6", label: "Jun"),
                          DropdownMenuEntry(value: "7", label: "Jul"),
                          DropdownMenuEntry(value: "8", label: "Aug"),
                          DropdownMenuEntry(value: "9", label: "Sept"),
                          DropdownMenuEntry(value: "10", label: "Oct"),
                          DropdownMenuEntry(value: "11", label: "Nov"),
                          DropdownMenuEntry(value: "12", label: "Dec"),
                        ],
                        onSelected: (String? val) {
                          if (val != null) {
                            setState(() {
                              int yearValue = int.parse(_selectedYear);
                              int monthValue = int.parse(val);
                              _selectedMonth = val;
                              _selectedDate = DateTime(yearValue, monthValue);
                              print("_selectedDate : " +
                                  _selectedDate.toString());
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 10,),

            FutureBuilder(
              future: TransactionModel.getAllTransactions(
                  selectedDate: _selectedDate),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  if (kDebugMode) {
                    print(snapshot.error);
                    return Expanded(
                        child: Center(
                          child: Text("Something Went Wrong!"),
                        ));
                  }
                }
                if (snapshot.hasData) {
                  List<TransactionModel>? data = snapshot.data;
                  if(data == null) {
                    return Container();
                  }
                  if (data.isEmpty) {
                    return Expanded(
                        child: Center(
                          child: Text("Sorry, No Transactions!"),
                        ));
                  }
                  return Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, int index) {
                          return Card(
                            child: ListTile(
                              leading: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: data[index].paymentStatus ==
                                        "SETTLED"
                                        ? Colors.green[600]
                                        : data[index].paymentStatus == "PENDING"
                                        ? Colors.blue[500]
                                        : Colors.orange[500]),
                                child: Text(
                                  data[index].paymentStatus.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                              title: Text(
                                "SHS " +
                                    data[index].totalAmount.toString() +
                                    " (${data[index].numberOfTickets})",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                    color: Colors.green[900], fontSize: 18),
                              ),
                              subtitle: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 80, child: Text("Phone")),
                                      Text(
                                        data[index].buyerPhone,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                            color: Colors.blue[900],
                                            fontSize: 14),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: 80, child: Text("Client")),
                                      Text(
                                        data[index].buyerNames,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                            color: Colors.blue[900],
                                            fontSize: 14),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 80, child: Text("Trip")),
                                      Text(
                                        data[index].tripNumber,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                            color: Colors.blue[900],
                                            fontSize: 14),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        data[index].companyName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                            color: Colors.green[900],
                                            fontSize: 14),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        dateToStringNew(data[index].createdAt) +
                                            "/" +
                                            dateToTime(
                                              data[index].createdAt,
                                            ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                            color: Colors.red,
                                            fontSize: 14),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                } else {
                  return Expanded(
                      child: Center(
                        child: LoadingWidget(),
                      ));
                }
              },
            ),

            // StreamBuilder(
            //   stream: TransactionModel.getAllTransactions(
            //       selectedDate: _selectedDate),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasError) {
            //       if (kDebugMode) {
            //         print(snapshot.error);
            //         return Expanded(
            //             child: Center(
            //           child: Text("Something Went Wrong!"),
            //         ));
            //       }
            //     }
            //     if (snapshot.hasData) {
            //       List<TransactionModel>? data = snapshot.data;
            //       if(data == null) {
            //         return Container();
            //       }
            //       if (data.isEmpty) {
            //         return Expanded(
            //             child: Center(
            //               child: Text("Sorry, No Transactions!"),
            //             ));
            //       }
            //       return Expanded(
            //         child: ListView.builder(
            //             itemCount: data.length,
            //             itemBuilder: (context, int index) {
            //               return Card(
            //                 child: ListTile(
            //                   leading: Container(
            //                     padding: EdgeInsets.symmetric(
            //                         horizontal: 5, vertical: 3),
            //                     decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(5),
            //                         color: data[index].paymentStatus ==
            //                                 "SETTLED"
            //                             ? Colors.green[600]
            //                             : data[index].paymentStatus == "PENDING"
            //                                 ? Colors.blue[500]
            //                                 : Colors.orange[500]),
            //                     child: Text(
            //                       data[index].paymentStatus.toUpperCase(),
            //                       style: Theme.of(context)
            //                           .textTheme
            //                           .bodyMedium!
            //                           .copyWith(
            //                               color: Colors.white, fontSize: 14),
            //                     ),
            //                   ),
            //                   title: Text(
            //                     "SHS " +
            //                         data[index].totalAmount.toString() +
            //                         " (${data[index].numberOfTickets})",
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .bodyMedium!
            //                         .copyWith(
            //                             color: Colors.green[900], fontSize: 18),
            //                   ),
            //                   subtitle: Column(
            //                     children: [
            //                       Row(
            //                         children: [
            //                           SizedBox(width: 80, child: Text("Phone")),
            //                           Text(
            //                             data[index].buyerPhone,
            //                             style: Theme.of(context)
            //                                 .textTheme
            //                                 .bodyMedium!
            //                                 .copyWith(
            //                                     color: Colors.blue[900],
            //                                     fontSize: 14),
            //                           )
            //                         ],
            //                       ),
            //                       Row(
            //                         children: [
            //                           SizedBox(
            //                               width: 80, child: Text("Client")),
            //                           Text(
            //                             data[index].buyerNames,
            //                             style: Theme.of(context)
            //                                 .textTheme
            //                                 .bodyMedium!
            //                                 .copyWith(
            //                                     color: Colors.blue[900],
            //                                     fontSize: 14),
            //                           )
            //                         ],
            //                       ),
            //                       Row(
            //                         children: [
            //                           SizedBox(width: 80, child: Text("Trip")),
            //                           Text(
            //                             data[index].tripNumber,
            //                             style: Theme.of(context)
            //                                 .textTheme
            //                                 .bodyMedium!
            //                                 .copyWith(
            //                                     color: Colors.blue[900],
            //                                     fontSize: 14),
            //                           )
            //                         ],
            //                       ),
            //                       SizedBox(
            //                         height: 10,
            //                       ),
            //                       Row(
            //                         mainAxisAlignment: MainAxisAlignment.end,
            //                         children: [
            //                           Text(
            //                             data[index].companyName,
            //                             style: Theme.of(context)
            //                                 .textTheme
            //                                 .bodyMedium!
            //                                 .copyWith(
            //                                     color: Colors.green[900],
            //                                     fontSize: 14),
            //                           )
            //                         ],
            //                       ),
            //                       Row(
            //                         mainAxisAlignment: MainAxisAlignment.end,
            //                         children: [
            //                           Text(
            //                             dateToStringNew(data[index].createdAt) +
            //                                 "/" +
            //                                 dateToTime(
            //                                   data[index].createdAt,
            //                                 ),
            //                             style: Theme.of(context)
            //                                 .textTheme
            //                                 .bodyMedium!
            //                                 .copyWith(
            //                                     color: Colors.red,
            //                                     fontSize: 14),
            //                           )
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               );
            //             }),
            //       );
            //     } else {
            //       return Expanded(
            //           child: Center(
            //         child: LoadingWidget(),
            //       ));
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
