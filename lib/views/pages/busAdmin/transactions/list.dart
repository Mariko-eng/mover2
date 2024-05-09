import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/transaction/transaction.dart';
import 'package:bus_stop_develop_admin/views/shared/utils.dart';
import 'package:flutter/material.dart';

class BusAdminTransactionsListView extends StatefulWidget {
  final BusCompany company;
  const BusAdminTransactionsListView({super.key, required this.company});

  @override
  State<BusAdminTransactionsListView> createState() => _BusAdminTransactionsListViewState();
}

class _BusAdminTransactionsListViewState extends State<BusAdminTransactionsListView> {
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
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: TransactionModel.getTransactionsByBusCompany(
                    companyId: widget.company.uid),
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
                                "Hey!\n No Data Found!",
                                textAlign: TextAlign.center,
                              )));
                    }
                    if (data.isEmpty) {
                      return Expanded(
                          child: Center(
                              child: Text(
                                "Hey!\n No Data Found!",
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
      ),
    );
  }
}
