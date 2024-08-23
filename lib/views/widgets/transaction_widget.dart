import 'package:bus_stop_develop_admin/models/transaction/transaction.dart';
import 'package:bus_stop_develop_admin/views/shared/utils.dart';
import 'package:flutter/material.dart';

class TransactionWidget extends StatelessWidget {
  final TransactionModel data;

  const TransactionWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    String amount = formatNumber(int.parse(data.paymentAmount));

    return Card(
      color: Colors.white,
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: data.paymentStatus == "SETTLED"
                  ? Colors.green[600]
                  : data.paymentStatus == "PENDING"
                      ? Colors.blue[500]
                      : data.paymentStatus == "ERROR"
                          ? Colors.red[500]
                          : Colors.orange[500]),
          child: Text(
            data.paymentStatus.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white, fontSize: 14),
          ),
        ),
        title: Text(
          "SHS " + amount + " (${data.numberOfTickets})",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.green[900], fontSize: 18),
        ),
        subtitle: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 80, child: Text("Client")),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.buyerNames,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.blue[900], fontSize: 14),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                SizedBox(width: 80, child: Text("Phone")),
                Text(
                  data.buyerPhone,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.blue[900], fontSize: 14),
                )
              ],
            ),
            Row(
              children: [
                SizedBox(width: 80, child: Text("Trip")),
                Text(
                  data.tripNumber,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.blue[900], fontSize: 14),
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
                  data.companyName,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.green[900], fontSize: 14),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  dateToStringNew(data.createdAt) +
                      "/" +
                      dateToTime(
                        data.createdAt,
                      ),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.red, fontSize: 14),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
