import 'package:flutter/material.dart';
import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/transaction/transaction.dart';
import 'package:bus_stop_develop_admin/views/shared/utils.dart';

class BusCompanyTransactionsListView extends StatefulWidget {
  final BusCompany company;
  final DateTime dateTime;
  final TextEditingController dateInput;
  const BusCompanyTransactionsListView({super.key, required this.company, required this.dateInput, required this.dateTime});

  @override
  State<BusCompanyTransactionsListView> createState() => _BusCompanyTransactionsListViewState();
}

class _BusCompanyTransactionsListViewState extends State<BusCompanyTransactionsListView> {

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
          FutureBuilder(
              future: TransactionModel.getTransactionsByBusCompanyAndDate(
                  date: widget.dateTime, companyId: widget.company.uid),
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
                              "${widget.dateInput.text}\n No Data Found!",
                              textAlign: TextAlign.center,
                            )));
                  }
                  if (data.isEmpty) {
                    return Expanded(
                        child: Center(
                            child: Text(
                              "${widget.dateInput.text}\n No Data Found!",
                              textAlign: TextAlign.center,
                            )));
                  }
                  return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, int index) {
                              return Card(
                                child: ListTile(
                                  // onTap: () {
                                  //   _openBottomSheet(destination: data[index]);
                                  // },
                                  leading: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: data[index].paymentStatus == "SETTLED" ? Colors.green[600] :
                                        data[index].paymentStatus == "PENDING" ? Colors.blue[500] : Colors.orange[500]
                                    ),
                                    child: Text(data[index].paymentStatus.toUpperCase(),
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: Colors.white,
                                          fontSize: 14
                                      ),
                                    ),
                                  ),
                                  title: Text("SHS "+data[index].totalAmount.toString() + " (${data[index].numberOfTickets})",
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        color: Colors.green[900],
                                        fontSize: 18
                                    ),
                                  ),
                                  subtitle: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                              width: 80,
                                              child: Text("Phone")),
                                          Text(data[index].buyerPhone,
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                color: Colors.blue[900],
                                                fontSize: 14
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                              width: 80,
                                              child: Text("Client")),
                                          Text(data[index].buyerNames,
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                color: Colors.blue[900],
                                                fontSize: 14
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                              width: 80,
                                              child: Text("Company")),
                                          Text(data[index].companyName,
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                color: Colors.blue[900],
                                                fontSize: 14
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                              width: 80,
                                              child: Text("Trip")),
                                          Text(data[index].tripNumber,
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                color: Colors.blue[900],
                                                fontSize: 14
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            dateToStringNew(data[index].createdAt) +
                                                "/" +
                                                dateToTime(data[index].createdAt,
                                                ),
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                color: Colors.red,
                                                fontSize: 14
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ));
                }
              }),
        ],
      ),
    );
  }
}
