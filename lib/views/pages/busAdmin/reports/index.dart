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
  @override
  void initState() {
    super.initState();
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
            Expanded(
              child: TabBarView(
                children: [
                  BusAdminReportTripsListView(
                    company: widget.company,
                  ),
                  BusAdminReportTicketsListView(
                    company: widget.company,
                  ),
                  BusCompanyTransactionsListView(
                    company: widget.company,
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
