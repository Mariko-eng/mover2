import 'package:bus_stop_develop_admin/config/collections/index.dart';
import 'package:bus_stop_develop_admin/models/Notifications.dart';
import 'package:bus_stop_develop_admin/models/customResponse.dart';
import 'package:bus_stop_develop_admin/models/trip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final CollectionReference tripsCollection = AppCollections.tripsRef;
final CollectionReference ticketsCollection = AppCollections.ticketsRef;

class TripTicket {
  final String ticketId;
  final String companyId;
  final String companyName;
  final String departureLocation;
  final String arrivalLocation;
  final int numberOfTickets;
  final int total;
  final int amountPaid;
  final String buyerNames;
  final String buyerPhoneNumber;
  final String buyerEmail;
  final String userId;
  final String paymentStatus;
  final bool paymentSuccessFul;
  final String paymentTransactionId;
  final String paymentTxRef;
  final String status;
  final String ticketType;
  final String ticketNumber;
  final String seatNumber;
  final DocumentReference tripRef;
  final String tripId;
  final Timestamp createdAt;
  final bool success;
  final String transactionId;
  Trip? trip;

  TripTicket(
      {required this.ticketId,
      required this.companyId,
      required this.companyName,
      required this.departureLocation,
      required this.arrivalLocation,
      required this.numberOfTickets,
      required this.total,
      required this.amountPaid,
      required this.ticketType,
      required this.ticketNumber,
        required this.seatNumber,
        required this.buyerNames,
      required this.buyerPhoneNumber,
      required this.buyerEmail,
      required this.userId,
      required this.status,
      required this.paymentStatus,
      required this.paymentSuccessFul,
      required this.paymentTransactionId,
      required this.paymentTxRef,
      required this.tripRef,
      required this.tripId,
      required this.success,
      required this.transactionId,
      required this.createdAt});

  factory TripTicket.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map;
    return TripTicket(
        ticketId: snapshot.id,
        companyId: data['companyId'],
        companyName: data['companyName'],
        departureLocation: data['departureLocation'] ?? "",
        arrivalLocation: data['arrivalLocation'] ?? "",
        numberOfTickets: data["numberOfTickets"] == null
            ? 0
            : int.parse(data["numberOfTickets"].toString()),
        total: data["total"] == null ? 0 : int.parse(data["total"].toString()),
        amountPaid: data["amountPaid"] == null
            ? 0
            : int.parse(data["amountPaid"].toString()),
        tripRef: data['trip'],
        ticketType: data['ticketType'] ?? "",
        ticketNumber: data['ticketNumber'] ?? "",
        seatNumber: data['seatNumber'] ?? "",
        buyerNames: data['buyerNames'] ?? "Nan",
        buyerEmail: data['buyerEmail'] ?? "Nan",
        buyerPhoneNumber: data['buyerPhoneNumber'] ?? "Nan",
        tripId: data['tripId'] ?? "",
        userId: data['userId'] ?? "",
        status: data['status'] ?? "",
        success: data['success'] ?? true,
        transactionId: data['transactionId'] ?? "",
        paymentStatus: data['paymentStatus'] ?? "",
        paymentSuccessFul: data['paymentSuccessFul'] ?? false,
        paymentTransactionId: data['paymentTransactionId'] ?? "",
        paymentTxRef: data['paymentTxRef'] ?? "",
        createdAt: data['createdAt'] ?? "");
  }

  Future<TripTicket?> setTripData(BuildContext context) async {
    try {
      DocumentSnapshot snapshot = await tripRef.get();
      if (snapshot.exists) {
        trip = Trip.fromSnapshot(snapshot);
        return this;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}

Stream<List<TripTicket>> getMyBusCompanyTicketsForATrip(
    {required String tripId}) {
  return ticketsCollection
      .where("tripId", isEqualTo: tripId)
      .orderBy("createdAt", descending: true)
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => TripTicket.fromSnapshot(doc)).toList();
  });
}

Stream<List<TripTicket>> getMyBusCompanyTickets(
    {required String companyId, required DateTime date}) {
  final startDate = DateTime(date.year, date.month, date.day);
  final endDate = DateTime(date.year, date.month, date.day + 1);

  return ticketsCollection
      .where("companyId", isEqualTo: companyId)
      .where('createdAt',
          isGreaterThanOrEqualTo: startDate, isLessThanOrEqualTo: endDate)
      .orderBy("createdAt", descending: true)
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => TripTicket.fromSnapshot(doc)).toList();
  });
}

// Stream<List<TripTicket>> getMyBusCompanyTickets1({required String companyId}) {
//   return ticketsCollection
//       .where("companyId", isEqualTo: companyId)
//       .orderBy("createdAt", descending: true)
//       .snapshots()
//       .map((snap) {
//     return snap.docs.map((doc) => TripTicket.fromSnapshot(doc)).toList();
//   });
// }

Stream<List<TripTicket>> getMyBusCompanyActiveTickets(
    {required String companyId, required String tripId}) {
  if (tripId == "All Tickets") {
    return ticketsCollection
        .where("companyId", isEqualTo: companyId)
        .where("status", isEqualTo: "pending")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) => TripTicket.fromSnapshot(doc)).toList();
    });
  } else {
    return ticketsCollection
        .where("companyId", isEqualTo: companyId)
        .where("tripId", isEqualTo: tripId)
        .where("status", isEqualTo: "pending")
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) => TripTicket.fromSnapshot(doc)).toList();
    });
  }
}

Stream<List<TripTicket>> getMyBusCompanyNonActiveTickets(
    {required String companyId, required String tripId}) {
  if (tripId == "All Tickets") {
    return ticketsCollection
        .where("companyId", isEqualTo: companyId)
        .where("status", whereIn: ["used", "cancelled"])
        .snapshots()
        .map((snap) {
          return snap.docs.map((doc) => TripTicket.fromSnapshot(doc)).toList();
        });
  } else {
    return ticketsCollection
        .where("companyId", isEqualTo: companyId)
        .where("tripId", isEqualTo: tripId)
        .where("status", whereIn: ["used", "cancelled"])
        .snapshots()
        .map((snap) {
          return snap.docs.map((doc) => TripTicket.fromSnapshot(doc)).toList();
        });
  }
}

Stream<List<TripTicket>> getAllTickets() {
  return ticketsCollection.snapshots().map((snap) {
    return snap.docs.map((doc) => TripTicket.fromSnapshot(doc)).toList();
  });
}

Future<TripTicket?> searchTicketByNumber({required String ticketNumber}) async {
  try {
    var res = await ticketsCollection
        .where("ticketNumber", isEqualTo: ticketNumber)
        .get();
    return TripTicket.fromSnapshot(res.docs.first);
  } catch (e) {
    print(e.toString());
    return null;
  }
}

Future<bool> updateTicketUsed(
    {required String ticketId,
    required String ticketNo,
    required String clientId,
    required String companyId}) async {
  try {
    await ticketsCollection.doc(ticketId).update({"status": "used"});
    await addClientNotification(
        clientId: clientId,
        busCompanyId: companyId,
        title: "Ticket Update",
        body: "Ticket " + ticketNo + " Has Been Used Successfully");
    await ticketsCollection
        .doc(ticketId)
        .update({'noOfVerifications': FieldValue.increment(1)});
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> updateTicketPending({required String ticketId}) async {
  try {
    await ticketsCollection.doc(ticketId).update({"status": "pending"});
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> updateTicketCancelled({required String ticketId}) async {
  try {
    await ticketsCollection.doc(ticketId).update({"status": "cancelled"});
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<CustomResponse> assignTicketSeatNumber({required String ticketId,required String seatNumber}) async {
  try {
    var res = await ticketsCollection.where(seatNumber, isEqualTo: seatNumber).get();
    if (res.docs.isNotEmpty){
      return CustomResponse(status: false, message: "Seat Number Is Already Taken!");
    }
    await ticketsCollection.doc(ticketId).update({"seatNumber": seatNumber});
    return CustomResponse(status: true, message: "Assigned Successfully!");
  } catch (e) {
    print(e.toString());
    return CustomResponse(status: false, message: e.toString());
  }
}

Future<bool> assignTicketToAnotherTrip(
    {required String ticketId,
    required Trip trip,
    required int numberOfTickets}) async {
  try {
    await ticketsCollection.doc(ticketId).update({
      'trip': tripsCollection.doc(trip.id),
      'tripId': trip.id,
      'departureLocation': trip.departureLocationName,
      'arrivalLocation': trip.arrivalLocationName,
    });

    DocumentReference tripRef = tripsCollection.doc(trip.id);
    await tripRef
        .update({'occupiedSeats': FieldValue.increment(numberOfTickets)});
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}
