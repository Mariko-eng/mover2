import 'package:bus_stop_develop_admin/models/transaction/transaction.dart';
import 'package:bus_stop_develop_admin/views/shared/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SuperAdminAllTransactionsList extends StatefulWidget {
  const SuperAdminAllTransactionsList({super.key});

  @override
  State<SuperAdminAllTransactionsList> createState() => _AllTransactionsListState();
}

class _AllTransactionsListState extends State<SuperAdminAllTransactionsList> {
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
            "All Transactions".toUpperCase(),
            style: TextStyle(color: Colors.red[900]),
          )),
      body: StreamBuilder(
        stream: TransactionModel.getAllTransactions(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            if (kDebugMode) {
              print(snapshot.error);
            }
          }
          if (snapshot.hasData) {
            List<TransactionModel>? data = snapshot.data;
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: data!.length,
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
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
