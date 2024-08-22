import 'package:flutter/material.dart';
import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/ticket.dart';
import 'package:bus_stop_develop_admin/views/shared/utils.dart';

class BusAdminReportTicketTileWidget extends StatefulWidget {
  final BusCompany company;
  final TripTicket tripTicket;

  const BusAdminReportTicketTileWidget({
    Key? key,
    required this.company,
    required this.tripTicket,
  }) : super(key: key);

  @override
  _BusAdminReportTicketTileState createState() => _BusAdminReportTicketTileState();
}

class _BusAdminReportTicketTileState extends State<BusAdminReportTicketTileWidget> {
  final TextEditingController _ctr = TextEditingController();
  bool isSubmitting = false;

  @override
  void dispose() {
    _ctr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 240,
        decoration: BoxDecoration(
          color: Colors.red[400],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.tripTicket.ticketType,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            widget.tripTicket.ticketNumber,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              fontSize: 17,
                              color: Colors.yellow[100],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Colors.red[900],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.tripTicket.status.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.yellow,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          dateToStringNew(
                              widget.tripTicket.trip!.departureTime),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.monetization_on,
                          color: Colors.blue[900],
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "SHS ${widget.tripTicket.total}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.green,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.tripTicket.trip!.departureLocationName,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.arrow_right_alt,
                          color: Colors.white70,
                          size: 20,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          widget.tripTicket.trip!.arrivalLocationName,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.cyan,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "${widget.tripTicket.buyerNames} - \n"
                              "${widget.tripTicket.buyerPhoneNumber}",                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.tripTicket.trip!.tripNumber,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                            fontSize: 14,
                            color: Colors.yellow,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.tripTicket.trip!.busPlateNo,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.tripTicket.createdAt.toDate().toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                            fontSize: 14,
                            color: Colors.blue[900],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            Container(
              width: 100,
              decoration: BoxDecoration(
                color: widget.tripTicket.status == "used"
                    ? Colors.indigo
                    : widget.tripTicket.status == "cancelled"
                    ? Colors.black
                    : Colors.red[900],
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.tripTicket.status == "pending"
                      ? const Icon(
                    Icons.chair,
                    color: Colors.white70,
                    size: 30,
                  )
                      : widget.tripTicket.status == "cancelled"
                      ? const Icon(
                    Icons.cancel,
                    color: Colors.white70,
                    size: 30,
                  )
                      : const Icon(
                    Icons.check_circle_outline,
                    color: Colors.white70,
                    size: 30,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.tripTicket.seatNumber,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 17, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
