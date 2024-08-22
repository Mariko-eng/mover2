import 'package:flutter/material.dart';
import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/reports/trips.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/reports/tickets.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/reports/transactions.dart';

class BusAdminReportsListView extends StatefulWidget {
  final BusCompany company;

  const BusAdminReportsListView({super.key, required this.company});

  @override
  State<BusAdminReportsListView> createState() => _BusReportsListViewState();
}

class _BusReportsListViewState extends State<BusAdminReportsListView> {
  TextEditingController dateInput = TextEditingController();

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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[900],
          automaticallyImplyLeading: false,
          toolbarHeight: 50,
          flexibleSpace: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      BackButton(
                        color: Colors.white,
                      ),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Reports By ${widget.company.name}",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )
                        ],
                      )),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 5,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              dividerColor: Colors.white,
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.bus_alert,
                    color: Colors.white,
                  ),
                  text: "Trips",
                ),
                Tab(
                  icon: Icon(
                    Icons.receipt,
                    color: Colors.white,
                  ),
                  text: "Tickets",
                ),
                Tab(
                  icon: Icon(
                    Icons.payment,
                    color: Colors.white,
                  ),
                  text: "Transactions",
                ),
              ]),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                // color: Colors.white,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("YYYY : "),
                            SizedBox(
                              width: 5,
                            ),
                            DropdownMenu(
                              menuHeight: 300,
                              initialSelection: _selectedYear,
                              // helperText: "Year",
                              dropdownMenuEntries: _years
                                  .map((item) => DropdownMenuEntry(
                                      value: item, label: item))
                                  .toList(),
                              onSelected: (String? val) {
                                if (val != null) {
                                  setState(() {
                                    int yearValue = int.parse(val);
                                    int monthValue = int.parse(_selectedMonth);
                                    _selectedYear = val;
                                    _selectedDate =
                                        DateTime(yearValue, monthValue);
                                    print("_selectedDate : " +
                                        _selectedDate.toString());
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("MM : "),
                            SizedBox(
                              width: 5,
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
                                    _selectedDate =
                                        DateTime(yearValue, monthValue);
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
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  BusAdminReportTripsListView(
                    company: widget.company,
                    dateTime: _selectedDate,
                    dateInput: dateInput,
                  ),
                  BusAdminReportTicketsListView(
                    company: widget.company,
                    dateTime: _selectedDate,
                    dateInput: dateInput,
                  ),
                  BusCompanyTransactionsListView(
                    company: widget.company,
                    dateTime: _selectedDate,
                    dateInput: dateInput,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
