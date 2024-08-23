import 'package:flutter/material.dart';
import 'package:bus_stop_develop_admin/models/ticket.dart';
import 'package:bus_stop_develop_admin/models/reports.dart';
import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/widgets/TicketTileReport.dart';

class BusAdminReportTicketsListView extends StatefulWidget {
  final BusCompany company;

  const BusAdminReportTicketsListView({super.key, required this.company});

  @override
  State<BusAdminReportTicketsListView> createState() =>
      _BusCompanyReportTicketsListViewState();
}

class _BusCompanyReportTicketsListViewState
    extends State<BusAdminReportTicketsListView> {
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Filters",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 18,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 5,
          ),
          LayoutBuilder(builder: (context, constraints) {
            return SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  DropdownMenu(
                    menuHeight: 300,
                    width: constraints.maxWidth * 0.45,
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
                          _selectedDate = DateTime(yearValue, monthValue);
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
                    width: constraints.maxWidth * 0.45,
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
                          _selectedDate = DateTime(yearValue, monthValue);
                          // print("_selectedDate : " +
                          //     _selectedDate.toString());
                        });
                      }
                    },
                  ),
                ],
              ),
            );
          }),
          SizedBox(
            height: 10,
          ),
          FutureBuilder(
              future: getTicketReportsForBusCompany(
                  selectedDate: _selectedDate, companyId: widget.company.uid),
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
                  List<TripTicket>? tickets = snapshot.data;
                  if (tickets == null) {
                    return Expanded(
                        child: Center(
                            child: Text(
                      "No Data Found!",
                      textAlign: TextAlign.center,
                    )));
                  }
                  if (tickets.isEmpty) {
                    return Expanded(
                        child: Center(
                            child: Text(
                      "No Data Found!",
                      textAlign: TextAlign.center,
                    )));
                  }
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total : ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: Colors.black, fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    tickets.length.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: Colors.blue[900],
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ListView.builder(
                              itemCount: tickets.length,
                              itemBuilder: (context, int index) {
                                return FutureBuilder(
                                  future: tickets[index].setTripData(context),
                                  // ignore: missing_return
                                  builder: (context, snapshot) {
                                    TripTicket? ticket = snapshot.data;
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        // if (index == 0) {
                                        //   return const LoadingWidget();
                                        // }
                                        return Container();
                                      case ConnectionState.none:
                                        return const Text(
                                          'No Tickets',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xFFE4191D),
                                              fontSize: 20.0),
                                        );
                                      case ConnectionState.active:
                                        return const Text('Searching... ');
                                      case ConnectionState.done:
                                        return ticket == null
                                            ? Container()
                                            : BusAdminReportTicketTileWidget(
                                                company: widget.company,
                                                tripTicket: ticket);
                                    }
                                  },
                                );
                              }),
                        )),
                      ],
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
