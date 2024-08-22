import 'package:bus_stop_develop_admin/config/collections/index.dart';
import 'package:bus_stop_develop_admin/models/ticket.dart';
import 'package:bus_stop_develop_admin/models/trip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ReportModel {
  final Trip trip;
  final List<TripTicket> tickets;

  ReportModel({required this.trip, required this.tickets});
}

// Future<List<ReportModel>> getReportsForBusCompany(
//     {required String companyId, required DateTime selectedDate}) async {
//   try {
//     // Define the start and end of the month
//     DateTime startOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
//     DateTime endOfMonth =
//         DateTime(selectedDate.year, selectedDate.month + 1, 0, 23, 59, 59, 999);
//
//     // final startDate = DateTime(date.year, date.month, date.day);
//     // final endDate = DateTime(date.year, date.month, date.day + 1);
//
//     List<ReportModel> reports = [];
//
//     var trips = await tripsCollection
//         .where('companyId', isEqualTo: companyId)
//         .where('departureTime',
//             isGreaterThanOrEqualTo: startOfMonth,
//             isLessThanOrEqualTo: endOfMonth)
//         .get();
//
//     List<Trip> dataTrips =
//         trips.docs.map((doc) => Trip.fromSnapshot(doc)).toList();
//
//     for (int i = 0; i < dataTrips.length; i++) {
//       Trip trip = dataTrips[i];
//       var res1 = await ticketsCollection
//           .where('trip', isEqualTo: tripsCollection.doc(dataTrips[i].id))
//           .get();
//
//       List<TripTicket> tickets =
//           res1.docs.map((doc) => TripTicket.fromSnapshot(doc)).toList();
//       reports.add(ReportModel(trip: trip, tickets: tickets));
//     }
//     return reports;
//   } catch (e) {
//     print(e.toString());
//     throw Exception(e.toString());
//   }
// }

Future<List<Trip>> getTripReportsForBusCompany(
    {required String companyId, required DateTime selectedDate}) async {
  try {
    // Define the start and end of the month
    DateTime startOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    DateTime endOfMonth =
        DateTime(selectedDate.year, selectedDate.month + 1, 0, 23, 59, 59, 999);

    // final startDate = DateTime(date.year, date.month, date.day);
    // final endDate = DateTime(date.year, date.month, date.day + 1);

    var trips = await AppCollections.tripsRef
        .where('companyId', isEqualTo: companyId)
        .where('departureTime',
            isGreaterThanOrEqualTo: startOfMonth,
            isLessThanOrEqualTo: endOfMonth)
        .orderBy("departureTime", descending: true)
        .get();

    List<Trip> dataTrips =
        trips.docs.map((doc) => Trip.fromSnapshot(doc)).toList();

    return dataTrips;
  } catch (e) {
    print(e.toString());
    throw Exception(e.toString());
  }
}

Future<List<TripTicket>> getTicketReportsForBusCompany(
    {required String companyId, required DateTime selectedDate}) async {
  try {
    // Define the start and end of the month
    DateTime startOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    DateTime endOfMonth =
        DateTime(selectedDate.year, selectedDate.month + 1, 0, 23, 59, 59, 999);

    // Convert DateTime to Timestamp for Firestore query
    Timestamp startTimestamp = Timestamp.fromDate(startOfMonth);
    Timestamp endTimestamp = Timestamp.fromDate(endOfMonth);

    print("Start Timestamp: $startTimestamp");
    print("End Timestamp: $endTimestamp");

    // // Perform the query
    // var tickets = await FirebaseFirestore.instance
    //     .collection('tickets')
    //     .where("companyId", isEqualTo: companyId)
    //     .where('createdAt',
    //     isGreaterThanOrEqualTo: startTimestamp,
    //     isLessThanOrEqualTo: endTimestamp)
    //     .orderBy("createdAt", descending: true)
    //     .get();

    var tickets = await AppCollections.ticketsRef
        .where("companyId", isEqualTo: companyId)
        .where('createdAt',
            isGreaterThanOrEqualTo: startOfMonth,
            isLessThanOrEqualTo: endOfMonth)
        .orderBy("createdAt", descending: true)
        .get();

    List<TripTicket> dataTickets =
        tickets.docs.map((doc) => TripTicket.fromSnapshot(doc)).toList();
    return dataTickets;
  } catch (e) {
    print(e.toString());
    throw Exception(e.toString());
  }
}
