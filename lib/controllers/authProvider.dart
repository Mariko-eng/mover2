import 'package:bus_stop_develop_admin/services/notifications.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:bus_stop_develop_admin/models/Notifications.dart';
import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/user/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:bus_stop_develop_admin/config/collections/index.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AdminUserModel? _userModel;

  AdminUserModel? get userModel => _userModel;

  BusCompany? _busCompany;

  BusCompany? get busCompany => _busCompany;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<NotificationsModel> _latestNotifications = [];

  List<NotificationsModel> get latestNotifications => _latestNotifications;

  UserProvider() {
    _fireSetUp();
  }

  _fireSetUp() {
    _isLoading = true;
    notifyListeners();
    _auth.authStateChanges().listen(_onStateChanged);
  }

  _onStateChanged(User? user) async {
    NotificationService notifyHelper = NotificationService();
    if (user == null) {
      _userModel = null;
      _isLoading = false;
      notifyListeners();
    } else {
      AdminUserModel? adminUser = await getAdminUserProfile(uid: user.uid);
      if (adminUser != null) {
        if (adminUser.isActive == false) {
          await _auth.signOut();
          _isLoading = false;
          notifyListeners();
        } else {
          if (adminUser.group == "bus_admin" ||
              adminUser.group == "bus_conductor") {
            if(adminUser.group == "bus_admin") {
              await notifyHelper.subscribeToFirebaseMessagingTopic(topic: "bus_admin");
            }
            if(adminUser.group == "bus_conductor") {
              await notifyHelper.subscribeToFirebaseMessagingTopic(topic: "bus_conductor");
            }
            BusCompany? busCompanyRes =
                await getBusCompanyProfile(companyId: adminUser.companyId);
            if (busCompanyRes != null) {
              _userModel = adminUser;
              _busCompany = busCompanyRes;
              _isLoading = false;
              notifyListeners();
              await updateToken(uid: user.uid);
            } else {
              _userModel = null;
              _isLoading = false;
              notifyListeners();
            }
          } else if (adminUser.group == "super_bus_admin") {
            await notifyHelper.subscribeToFirebaseMessagingTopic(topic: "super_bus_admin");
            _userModel = adminUser;
            _isLoading = false;
            notifyListeners();
            await updateToken(uid: user.uid);
          } else {
            _userModel = null;
            await _auth.signOut();
            _isLoading = false;
            notifyListeners();
          }
        }
      } else {
        _userModel = null;
        await _auth.signOut();
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      bool isValid = await validateUserAccount(email: email);
      if (isValid == false) {
        Get.snackbar("Sorry", "Account Not Found!",
            backgroundColor: Colors.orange, colorText: Colors.white);
        return false;
      }

      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Get.snackbar("Failed", e.message!,
          backgroundColor: Colors.orange, colorText: Colors.white);
      return false;
    } catch (e) {
      Get.snackbar("Failed", "Something Went Wrong",
          backgroundColor: Colors.orange, colorText: Colors.white);
      return false;
    }
  }

  Future updateToken({required String uid}) async {
    var fcm = FirebaseMessaging.instance;
    try {
      String? token = await fcm.getToken();

      await AppCollections.adminAccountsRef.doc(uid).update({"token": token});
    } catch (e) {
      print("Failed To Update FCM Token");
      print(e.toString());
    }
  }

  Future signOut() async {
    _isLoading = true;
    notifyListeners();
    await _auth.signOut();
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> validateUserAccount({required String email}) async {
    AdminUserModel? adminUser = await checkIfUserExistsByEmail(email);

    if (adminUser == null) {
      return false;
    } else if (adminUser.isActive == false) {
      return false;
    } else {
      return true;
    }
  }
}
