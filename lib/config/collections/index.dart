import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bus_stop_develop_admin/config/collections/prod.dart';
import 'package:bus_stop_develop_admin/config/collections/dev.dart';

class AppCollections {
  // static CollectionReference groupsRef = prodGroups;
  // static CollectionReference adminAccountsRef = prodAdminAccounts;
  // static CollectionReference clientsRef = prodClients;
  // static CollectionReference companiesRef = prodCompanies;
  // static CollectionReference destinationsRef = prodDestinations;
  // static CollectionReference transactionsRef = prodTransactions;
  // static CollectionReference ticketsRef = prodTickets;
  // static CollectionReference ticketsPreRef = prodTicketsPre;
  // static CollectionReference ticketsHistoryRef = prodTicketsHistory;
  // static CollectionReference tripsRef = prodTrips;
  // static CollectionReference notificationsRef = prodNotifications;
  // static CollectionReference infoRef = prodInfo;


  static CollectionReference groupsRef = testGroups;
  static CollectionReference adminAccountsRef = testAdminAccounts;
  static CollectionReference clientsRef = testClients;
  static CollectionReference companiesRef = testCompanies;
  static CollectionReference destinationsRef = testDestinations;
  static CollectionReference transactionsRef = testTransactions;
  static CollectionReference ticketsRef = testTickets;
  static CollectionReference ticketsPreRef = testTicketsPre;
  static CollectionReference ticketsHistoryRef = testTicketsHistory;
  static CollectionReference tripsRef = testTrips;
  static CollectionReference notificationsRef = testNotifications;
  static CollectionReference infoRef = testInfo;

}
