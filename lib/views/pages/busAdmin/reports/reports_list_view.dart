import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/reports.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/reports/reports_tickets_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class BusReportsListView extends StatefulWidget {
  final BusCompany company;

  const BusReportsListView({super.key, required this.company});

  @override
  State<BusReportsListView> createState() => _BusReportsListViewState();
}

class _BusReportsListViewState extends State<BusReportsListView> {
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
    return Scaffold(
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
          title: Text(
            "Reports".toUpperCase(),
            style: TextStyle(color: Colors.red[900]),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            const Text(
              "Select Date",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  height: 50,
                  child: TextField(
                    controller: dateInput,
                    readOnly: true,
                    decoration: const InputDecoration(
                        icon: Icon(
                      Icons.calendar_today,
                      color: Colors.red,
                    )),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        setState(() {
                          _dateTime = pickedDate;
                          dateInput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {}
                    },
                  ),
                ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: getReportsForBusCompany(
                    date: _dateTime, companyId: widget.company.uid),
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
                    List<ReportModel>? data = snapshot.data;
                    return Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: ListView.builder(
                          itemCount: data!.length,
                          itemBuilder: (context, int i) {
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  Get.to(() => ReportTripTickets(
                                      company: widget.company,
                                      reportModel: data[i]));
                                },
                                leading: const Icon(
                                  Icons.bus_alert,
                                  color: Colors.red,
                                ),
                                title: Row(
                                  children: [
                                    Text(
                                      data[i].trip.departureLocationName,
                                    ),
                                    Icon(Icons.arrow_circle_right_rounded),
                                    Text(
                                      data[i].trip.arrivalLocationName,
                                    ),
                                  ],
                                ),
                                trailing: Text(
                                  data[i].tickets.length.toString(),
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.red[900],
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Text(
                                                "View Tickets",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
