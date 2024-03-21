import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference prodGroups = FirebaseFirestore.instance.collection("groups");
CollectionReference prodAdminAccounts = FirebaseFirestore.instance.collection("admin_accounts");
CollectionReference prodClients = FirebaseFirestore.instance.collection("clients");
CollectionReference prodCompanies = FirebaseFirestore.instance.collection("companies");
CollectionReference prodDestinations = FirebaseFirestore.instance.collection("destinations");
CollectionReference prodTickets = FirebaseFirestore.instance.collection("tickets");
CollectionReference prodTicketsPre = FirebaseFirestore.instance.collection("tickets_pre");
CollectionReference prodTicketsHistory = FirebaseFirestore.instance.collection("tickets_history");
CollectionReference prodTrips = FirebaseFirestore.instance.collection("trips");
CollectionReference prodNotifications = FirebaseFirestore.instance.collection("notifications");
CollectionReference prodInfo = FirebaseFirestore.instance.collection("news_info");
