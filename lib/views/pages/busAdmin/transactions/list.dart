import 'package:flutter/material.dart';
import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/transaction/transaction.dart';
import 'package:bus_stop_develop_admin/views/shared/utils.dart';
import 'package:bus_stop_develop_admin/views/widgets/transaction_widget.dart';

class BusAdminTransactionsListView extends StatefulWidget {
  final BusCompany company;

  const BusAdminTransactionsListView({super.key, required this.company});

  @override
  State<BusAdminTransactionsListView> createState() =>
      _BusAdminTransactionsListViewState();
}

class _BusAdminTransactionsListViewState
    extends State<BusAdminTransactionsListView> {
  List<String> _years = [];
  late String _selectedYear;
  late String _selectedMonth;
  late DateTime _selectedDate;
  late String _selectedStatus;

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
      _selectedStatus = "all";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffdfdfd),
      appBar: AppBar(
        backgroundColor: Color(0xfffdfdfd),
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "Transactions",
          style: TextStyle(color: Color(0xff62020a)),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
              width: 20,
              height: 25,
              child: Image.asset(
                'assets/images/back_arrow.png',
              )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  LayoutBuilder(builder: (context, constraints) {
                    return SizedBox(
                      height: 80,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          DropdownMenu(
                            menuHeight: 300,
                            width: constraints.maxWidth * 0.35,
                            initialSelection: _selectedYear,
                            helperText: "Year",
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
                                  _selectedDate =
                                      DateTime(yearValue, monthValue);
                                  // print("_selectedDate : " +
                                  //     _selectedDate.toString());
                                });
                              }
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          DropdownMenu(
                            menuHeight: 300,
                            width: constraints.maxWidth * 0.35,
                            initialSelection: _selectedMonth,
                            helperText: "Month",
                            dropdownMenuEntries: const [
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
                                  _selectedDate =
                                      DateTime(yearValue, monthValue);
                                  // print("_selectedDate : " +
                                  //     _selectedDate.toString());
                                });
                              }
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          DropdownMenu(
                            menuHeight: 300,
                            width: constraints.maxWidth * 0.35,
                            initialSelection: _selectedStatus,
                            helperText: "Status",
                            dropdownMenuEntries: const [
                              DropdownMenuEntry(value: "all", label: "All"),
                              DropdownMenuEntry(
                                  value: "settled", label: "Settled"),
                              DropdownMenuEntry(
                                  value: "refused", label: "Refused"),
                              DropdownMenuEntry(value: "error", label: "Error"),
                              DropdownMenuEntry(
                                  value: "pending", label: "Pending"),
                            ],
                            onSelected: (String? val) {
                              if (val != null) {
                                setState(() {
                                  _selectedStatus = val;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: TransactionModel.getTransactionsByBusCompany(
                    companyId: widget.company.uid, selectedDate: _selectedDate),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Expanded(
                        child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Something has Gone Wrong!"),
                        ],
                      ),
                    ));
                  }
                  if (!snapshot.hasData) {
                    return const Expanded(
                        child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    ));
                  } else {
                    List<TransactionModel>? data = snapshot.data;
                    if (data == null) {
                      return Expanded(
                          child: Center(
                              child: Text(
                        "No Data Found!",
                        textAlign: TextAlign.center,
                      )));
                    }
                    if (data.isEmpty) {
                      return Expanded(
                          child: Center(
                              child: Text(
                        "No Data Found!",
                        textAlign: TextAlign.center,
                      )));
                    }
                    int settled = 0;
                    int settledAmt = 0;
                    int refused = 0;
                    int refusedAmt = 0;
                    for (int i = 0; i < data.length; i++) {
                      if (data[i].paymentStatus.toLowerCase() == "settled") {
                        settled += 1;
                        settledAmt += int.parse(data[i].paymentAmount);
                      }
                      if (data[i].paymentStatus.toLowerCase() == "refused") {
                        refused += 1;
                        refusedAmt += int.parse(data[i].paymentAmount);
                      }

                      if (data[i].paymentStatus.toLowerCase() == "error") {
                        refused += 1;
                        refusedAmt += int.parse(data[i].paymentAmount);
                      }
                    }

                    List<TransactionModel> filteredData =
                        _filter(data, _selectedStatus);

                    return Expanded(
                      child: Column(
                        children: [
                          Container(
                            color: Colors.blue[100]!.withOpacity(0.3),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Summary",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      " + Transactions Count",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: Colors.blue[900],
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 40,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Settled",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              " : " + settled.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Colors.blue[900],
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Refused | Error",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              " : " + refused.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Colors.blue[900],
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Total",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              " : " + data.length.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Colors.blue[900],
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      " + Transactions Amount",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: Colors.blue[900],
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 40,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Settled",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              " : " + formatNumber(settledAmt),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Colors.blue[900],
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Refused | Error",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              " : " + formatNumber(refusedAmt),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Colors.blue[900],
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Expanded(
                              child: ListView.builder(
                                  itemCount: filteredData.length,
                                  itemBuilder: (context, int index) {
                                    return TransactionWidget(
                                        data: filteredData[index]);
                                  })),
                        ],
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  List<TransactionModel> _filter(List<TransactionModel> data, String status) {
    if (status != "all") {
      return data
          .where((element) => element.paymentStatus.toLowerCase() == status)
          .toList();
    }
    return data;
  }
}
