import 'package:bus_stop_develop_admin/config/collections/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference transactionsCollection =
    AppCollections.transactionsRef;

class TransactionModel {
  final String transactionId;
  final String companyId;
  final String companyName;
  final String tripId;
  final String tripNumber;
  final String departureLocationId;
  final String departureLocationName;
  final String arrivalLocationId;
  final String arrivalLocationName;
  final String ticketType;

  final String ticketPrice;
  final String numberOfTickets;
  final String totalAmount;

  final String buyerNames;
  final String buyerPhone;
  final String buyerEmail;
  final String clientId;
  final String clientUsername;
  final String clientEmail;
  final String paymentStatus;
  final String paymentAccount;

  final String paymentAmount;

  final String paymentWallet;
  final String paymentMemo;

  final DateTime createdAt;

  TransactionModel(
      {required this.transactionId,
      required this.companyId,
      required this.companyName,
      required this.tripId,
      required this.tripNumber,
      required this.departureLocationId,
      required this.departureLocationName,
      required this.arrivalLocationId,
      required this.arrivalLocationName,
      required this.ticketType,
      required this.numberOfTickets,
      required this.ticketPrice,
      required this.totalAmount,
      required this.buyerNames,
      required this.buyerPhone,
      required this.buyerEmail,
      required this.clientId,
      required this.clientUsername,
      required this.clientEmail,
      required this.createdAt,
      required this.paymentStatus,
      required this.paymentAccount,
      required this.paymentAmount,
      required this.paymentWallet,
      required this.paymentMemo});

  factory TransactionModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map;
    return TransactionModel(
        transactionId: snapshot.id,
        companyId: data['companyId'] ?? "",
        companyName: data['companyName'] ?? "",
        tripId: data['tripId'] ?? "",
        tripNumber: data['tripNumber'] ?? "",
        arrivalLocationId: data['arrivalLocationId'] ?? "",
        arrivalLocationName: data['arrivalLocationName'] ?? "",
        departureLocationId: data['departureLocationId'] ?? "",
        departureLocationName: data['departureLocationName'] ?? "",
        ticketType: data['ticketType'] ?? "",
        ticketPrice:
            data['ticketPrice'] == null ? "" : data['ticketPrice'].toString(),
        numberOfTickets: data['numberOfTickets'] == null
            ? ""
            : data['numberOfTickets'].toString(),
        totalAmount:
            data['totalAmount'] == null ? "" : data['totalAmount'].toString(),
        buyerNames: data['buyerNames'] ?? "",
        buyerPhone: data['buyerPhone'] ?? "",
        buyerEmail: data['buyerEmail'] ?? "",
        clientId: data['clientId'] ?? "",
        clientUsername: data['clientUsername'] ?? "",
        clientEmail: data['clientEmail'] ?? "",
        paymentStatus: data['paymentStatus'] ?? "PENDING",
        paymentAccount: data['paymentAccount'] ?? "",
        paymentAmount: data['paymentAmount'] == null
            ? ""
            : data['paymentAmount'].toString(),
        paymentWallet: data['paymentWallet'] ?? "",
        paymentMemo: data['paymentMemo'] ?? "",
        createdAt: DateTime.parse(data['createdAt']));
  }

  static Future<List<TransactionModel>> getAllTransactions(
      {required DateTime selectedDate}) async {
    // Define the start and end of the month
    DateTime startOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    DateTime endOfMonth =
        DateTime(selectedDate.year, selectedDate.month + 1, 0, 23, 59, 59, 999);

    try {
      var results = await AppCollections.transactionsRef
          .where('createdAt',
              isGreaterThanOrEqualTo: startOfMonth.toIso8601String(),
              isLessThanOrEqualTo: endOfMonth.toIso8601String())
          .orderBy("createdAt", descending: true)
          .get();

      return results.docs
          .map((doc) => TransactionModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      throw e.toString();
    }

  }

  static Stream<List<TransactionModel>> getAllTransactions1(
      {required DateTime selectedDate}) {
    // Define the start and end of the month
    DateTime startOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    DateTime endOfMonth =
        DateTime(selectedDate.year, selectedDate.month + 1, 0, 23, 59, 59, 999);


    return AppCollections.transactionsRef
        .where('createdAt',
        isGreaterThanOrEqualTo: startOfMonth.toIso8601String(),
        isLessThanOrEqualTo: endOfMonth.toIso8601String())
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snap) {
      return snap.docs
          .map((doc) => TransactionModel.fromSnapshot(doc))
          .toList();
    });
  }

  static Future<List<TransactionModel>> getTransactionsByBusCompany(
      {required String companyId,required DateTime selectedDate}) async {
    // Define the start and end of the month
    DateTime startOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    DateTime endOfMonth =
    DateTime(selectedDate.year, selectedDate.month + 1, 0, 23, 59, 59, 999);

    try {
      var results = await AppCollections.transactionsRef
          .where('companyId', isEqualTo: companyId)
          .where('createdAt',
          isGreaterThanOrEqualTo: startOfMonth.toIso8601String(),
          isLessThanOrEqualTo: endOfMonth.toIso8601String())
          .orderBy("createdAt", descending: true)
          .get();

      return results.docs
          .map((doc) => TransactionModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }
}
