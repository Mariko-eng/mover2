import 'package:bus_stop_develop_admin/config/collections/index.dart';
import 'package:bus_stop_develop_admin/models/Notifications.dart';
import 'package:bus_stop_develop_admin/models/customResponse.dart';
import 'package:bus_stop_develop_admin/models/transaction/transaction.dart';
import 'package:bus_stop_develop_admin/models/trip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

Future<CustomResponse> assignTicketSeatNumber(
    {required String ticketId, required String seatNumber}) async {
  try {
    var res =
        await ticketsCollection.where(seatNumber, isEqualTo: seatNumber).get();
    if (res.docs.isNotEmpty) {
      return CustomResponse(
          status: false, message: "Seat Number Is Already Taken!");
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




// Future getData() async {
//   try {
//
//     var tripresults = await tripsCollection.doc("yCrwbNaJ7xUJvjq3YeCH").get();
//     var ticketresults = await ticketsCollection.doc("DZrZgryd6lSTbSjj8gwF").get();
//
//     var clientresults = await AppCollections.clientsRef.doc("QTqgy7GzjfX5yzAkuWP8JfzWxX72").get();
//
//     print("tripresults");
//     print(tripresults);
//     print("ticketresults");
//     print(ticketresults);
//
//     print("Trip");
//     Trip tp = Trip.fromSnapshot(tripresults);
//     print("tp.id : " + tp.id);
//     print("tp.tripNumber : " + tp.tripNumber);
//
//     print("Ticket");
//     TripTicket tk = TripTicket.fromSnapshot(ticketresults);
//     print(tk);
//
//     print("Client");
//     print(clientresults.id);
//     print(clientresults.get("email"));
//     print(clientresults.get("username"));
//     print(clientresults.get("phoneNumber"));
//
//
//
//   //   var trans = {
//   //     "buyerEmail" : clientresults.get("email"),
//   //     "buyerNames" : clientresults.get("username"),
//   //     "buyerPhone" : clientresults.get("phoneNumber"),
//   //     "clientEmail" : clientresults.get("email"),
//   //     "clientId" : clientresults.id,
//   //     "clientUsername" : clientresults.get("username"),
//   //
//   //     "arrivalLocationName" : "NAIROBI",
//   //     "arrivalLocationId" : "2j4uzGPFvKrJoDE3KTQb",
//   //     "departureLocationName" : "KAMPALA",
//   //     "departureLocationId" : "sHyqy19irxD5GNwCbeUH",
//   //
//   //     "companyId" : "vhL65Z8TCjSf2L6TTwjOHml21Sp2",
//   //     "companyName" : "SIMBA COOL EA LIMITED",
//   //
//   //     "numberOfTickets" : 2,
//   //     "paymentAccount" : clientresults.get("phoneNumber"),
//   //
//   //     "paymentAmount" : 204000,
//   //     "paymentMemo" : "SIMBA COOL EA LIMITED",
//   //     "paymentStatus" : "SETTLED",
//   //     "paymentWallet" : "flw",
//   //
//   //     "ticketPrice" : 94000,
//   //     "ticketType" : "VIP",
//   //     "totalAmount" : 204000,
//   //
//   //     "tripId": tripresults.id,
//   //     "tripNumber" : tripresults.get("tripNumber"),
//   //
//   //     "culipaTxId" : "",
//   //
//   //     "createdAt" : DateTime.now().toIso8601String(),
//   // };
//   //
//   //   DocumentReference doc = await transactionsCollection.add(trans);
//   //
//   //   await ticketsCollection.doc("DZrZgryd6lSTbSjj8gwF").update({
//   //     'preTicketId': "",
//   //     'transactionId': doc.id,
//   //     "buyerEmail" : clientresults.get("email"),
//   //     "buyerNames" : clientresults.get("username"),
//   //     "buyerPhoneNumber" : clientresults.get("phoneNumber"),
//   //     'userEmail': clientresults.get("email"),
//   //   });
//
//     print("finished");
//
//   }catch(e) {
//    print(e.toString());
//   }
// }
