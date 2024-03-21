import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_stop_develop_admin/views/auth/wrapper.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bus_stop_develop_admin/controllers/authProvider.dart';
import 'package:bus_stop_develop_admin/models/user/user.dart';

class MyAccountView extends StatefulWidget {
  const MyAccountView({super.key});

  @override
  State<MyAccountView> createState() => _MyAccountViewState();
}

class _MyAccountViewState extends State<MyAccountView> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: 55,
                        height: 45,
                        child: Image.asset("assets/images/image6.png")),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("My ACCOUNT".toUpperCase())],
                )
              ],
            ),
          ),
        ),
      ),
      body: userProvider.userModel == null
          ? Container()
          : Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: Column(
                  children: [
                    Divider(),
                    Column(
                      children: [
                        Row(
                          children: [Text("Username")],
                        ),
                        Row(
                          children: [
                            Text(userProvider.userModel!.name,
                              style: TextStyle(color: Colors.blue[800]),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    Column(
                      children: [
                        Row(
                          children: [Text("Phone")],
                        ),
                        Row(
                          children: [
                            Text(userProvider.userModel!.phoneNumber,
                              style: TextStyle(color: Colors.blue[800]),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    Column(
                      children: [
                        Row(
                          children: [Text("Contact Email")],
                        ),
                        Row(
                          children: [
                            Text(userProvider.userModel!.contactEmail,
                              style: TextStyle(color: Colors.blue[800]),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    Column(
                      children: [
                        Row(
                          children: [Text("Account Email")],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(userProvider.userModel!.email,
                              style: TextStyle(color: Colors.blue[800]),
                            ),
                            GestureDetector(
                              onTap: (){
                                _showEmailInputDialog(context);
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.edit,color: Colors.yellow[700],),
                                  Text("Edit",
                                    style: TextStyle(color: Colors.yellow[700]),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    Column(
                      children: [
                        Row(
                          children: [Text("Delete This Account?")],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            GestureDetector(
                              onTap: (){
                                _showDeleteConfirmationDialog(context);
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.delete,color: Colors.red[700],),
                                  Text("Delete",
                                    style: TextStyle(color: Colors.red[700]),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back,color: Colors.red[700],),
                          Text("Go Back",
                            style: TextStyle(color: Colors.red[700]),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
          ),
    );
  }

  void _showEmailInputDialog(BuildContext context) {
    String newEmail = '';
    String password = ''; // Added password variable

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Account Email'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Enter New Email'),
                onChanged: (value) {
                  newEmail = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Enter Current Password'),
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                  final bool isValidEmail = EmailValidator.validate(newEmail);
                  if (!isValidEmail) {
                    Get.snackbar(
                        "Enter a valid email!",
                        "Try Again",
                        colorText: Colors.white,
                        backgroundColor: Colors.red);
                    return;
                  }
                  if(password.length < 4) {
                    Get.snackbar(
                        "Enter a valid password!",
                        "Try Again",
                        colorText: Colors.white,
                        backgroundColor: Colors.red);
                    return;
                  }
                  print(newEmail);
                  print(password);

                // _updateEmail(context, newEmail);
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}

Future<void> _updateEmail({required BuildContext context, required String newEmail, required String currentPassword}) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword, // Replace with the user's current password
      );

      await user.reauthenticateWithCredential(credential);
      await user.verifyBeforeUpdateEmail(newEmail);
      // await user.updateEmail(newEmail);

      // Optionally sign out the user and prompt them to sign in again with their new email
      await FirebaseAuth.instance.signOut();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Email updated successfully'),
      ));

      Get.offAll(() => const Wrapper());
    }
  } catch (e) {
    print('Failed to update email: $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Failed to update email. Please try again.'),
    ));
  }
}

void _showDeleteConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Account Deletion'),
        content: Text('Are you sure you want to delete your account? This action cannot be undone.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _deleteAccount(context);
            },
            child: Text('Delete'),
          ),
        ],
      );
    },
  );
}

Future<void> _deleteAccount(BuildContext context) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.delete();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Account deleted successfully'),
      ));

      Get.offAll(() => const Wrapper());
      // Optionally navigate to a different screen after deletion
    }
  } catch (e) {
    print('Failed to delete account: $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Failed to delete account. Please try again.'),
    ));
  }
}



