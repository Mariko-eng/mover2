import 'package:firebase_auth/firebase_auth.dart';

Future<bool> isEmailAlreadyRegistered(String email) async {
  try {
    final methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

    // If the methods list is not empty, the email is already registered.
    if(methods.isNotEmpty){
      return true;
    }else{
      return false;
    }
    // return methods.isNotEmpty;
  } catch (error) {
    // Handle any errors here, such as network issues or invalid email format.
    print("Error checking email registration: $error");
    // return false;
    throw Exception(error);
  }
}
