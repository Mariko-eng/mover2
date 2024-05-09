import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference testGroups = FirebaseFirestore.instance.collection("test_groups");
CollectionReference testAdminAccounts = FirebaseFirestore.instance.collection("test_admin_accounts");
CollectionReference testClients = FirebaseFirestore.instance.collection("test_clients");
CollectionReference testCompanies = FirebaseFirestore.instance.collection("test_companies");
CollectionReference testDestinations = FirebaseFirestore.instance.collection("test_destinations");
CollectionReference testNotifications = FirebaseFirestore.instance.collection("test_notifications");
CollectionReference testTransactions = FirebaseFirestore.instance.collection("test_transactions");
CollectionReference testTickets = FirebaseFirestore.instance.collection("test_tickets");
CollectionReference testTicketsPre = FirebaseFirestore.instance.collection("test_tickets_pre");
CollectionReference testTicketsHistory = FirebaseFirestore.instance.collection("test_tickets_history");
CollectionReference testTrips = FirebaseFirestore.instance.collection("test_trips");
CollectionReference testInfo = FirebaseFirestore.instance.collection("test_news_info");
