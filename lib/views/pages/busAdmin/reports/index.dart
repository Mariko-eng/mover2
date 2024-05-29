import 'package:flutter/material.dart';
import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/reports/trip_tickets/trips.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/reports/transactions/transactions_list_view.dart';
import 'package:intl/intl.dart';

class BusAdminReportsListView extends StatefulWidget {
  final BusCompany company;

  const BusAdminReportsListView({super.key, required this.company});

  @override
  State<BusAdminReportsListView> createState() => _BusReportsListViewState();
}

class _BusReportsListViewState extends State<BusAdminReportsListView> {
  TextEditingController dateInput = TextEditingController();

  late DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    setState(() {
      _dateTime = DateTime.now();
      dateInput.text = DateFormat('yyyy-MM-dd').format(_dateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          title: Column(
            children: [
              Text(
                widget.company.name.toUpperCase(),
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.red[900],fontWeight: FontWeight.bold),
              ),
              Text(
                "Reports".toUpperCase(),
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue[900]),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 80),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        dateInput.text,
                        style: TextStyle(color: Colors.red[900]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2100));

                                  if (pickedDate != null) {//pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                    DateFormat('yyyy-MM-dd')
                                        .format(pickedDate); //formatted date output using intl package =>  2021-03-16
                                    setState(() {
                                      _dateTime = pickedDate;
                                      dateInput.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  } else {}
                                },
                                child: Icon(Icons.calendar_month,color: Colors.blue,)),
                            Text("Edit Date",style: TextStyle(color: Colors.blue),)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                TabBar(
                  tabs: [
                    Tab(
                      text: "Tickets",
                    ),
                    Tab(
                      text: "Transactions",
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            BusAdminReportTripsListView(
              company: widget.company,
              dateTime: _dateTime,
              dateInput: dateInput,
            ),
            BusCompanyTransactionsListView(
              company: widget.company,
              dateTime: _dateTime,
              dateInput: dateInput,
            )
          ],
        ),
      ),
    );
  }
}
