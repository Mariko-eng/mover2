import 'package:bus_stop_develop_admin/config/collections/index.dart';
import 'package:bus_stop_develop_admin/models/ticket.dart';
import 'package:bus_stop_develop_admin/models/trip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference tripsCollection =
    AppCollections.tripsRef;
final CollectionReference ticketsCollection =
    AppCollections.tripsRef;

class ReportModel {
  final Trip trip;
  final List<TripTicket> tickets;

  ReportModel({required this.trip, required this.tickets});
}

Future<List<ReportModel>> getReports({required DateTime date}) async {
  try {
    final startDate = DateTime(date.year, date.month, date.day);
    final endDate = DateTime(date.year, date.month, date.day + 1);

    List<ReportModel> reports = [];

    var trips = await tripsCollection
        .where('departureTime',
            isGreaterThanOrEqualTo: startDate, isLessThanOrEqualTo: endDate)
        .get();

    List<Trip> dataTrips =
        trips.docs.map((doc) => Trip.fromSnapshot(doc)).toList();

    for (int i = 0; i < dataTrips.length; i++) {
      Trip trip = dataTrips[i];
      var res1 = await ticketsCollection
          .where('trip', isEqualTo: tripsCollection.doc(dataTrips[i].id))
          .get();

      List<TripTicket> tickets =
          res1.docs.map((doc) => TripTicket.fromSnapshot(doc)).toList();
      reports.add(ReportModel(trip: trip, tickets: tickets));
    }
    return reports;
  } catch (e) {
    print(e.toString());
    throw Exception(e.toString());
  }
}

Future<List<ReportModel>> getReportsForBusCompany(
    {required DateTime date, required String companyId}) async {
  try {
    final startDate = DateTime(date.year, date.month, date.day);
    final endDate = DateTime(date.year, date.month, date.day + 1);

    List<ReportModel> reports = [];

    var trips = await tripsCollection
        .where('companyId', isEqualTo: companyId)
        .where('departureTime',
            isGreaterThanOrEqualTo: startDate, isLessThanOrEqualTo: endDate)
        .get();

    List<Trip> dataTrips =
        trips.docs.map((doc) => Trip.fromSnapshot(doc)).toList();

    for (int i = 0; i < dataTrips.length; i++) {
      Trip trip = dataTrips[i];
      var res1 = await ticketsCollection
          .where('trip', isEqualTo: tripsCollection.doc(dataTrips[i].id))
          .get();

      List<TripTicket> tickets =
          res1.docs.map((doc) => TripTicket.fromSnapshot(doc)).toList();
      reports.add(ReportModel(trip: trip, tickets: tickets));
    }
    return reports;
  } catch (e) {
    print(e.toString());
    throw Exception(e.toString());
  }
}
