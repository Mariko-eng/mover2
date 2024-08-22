import 'package:bus_stop_develop_admin/controllers/authProvider.dart';
import 'package:bus_stop_develop_admin/models/ticket.dart';
import 'package:bus_stop_develop_admin/views/shared/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isPasswordHidden = true;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    UserProvider _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Center(
                    child: Image.asset(
                  'assets/images/image12.png',
                )),
              ),
              decoration: const BoxDecoration(
                  color: Color(0xff62020a),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  )),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xffffffff),
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          // color: const Color(0xffe5e5e5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          "Bus Stopper".toUpperCase(),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff62020a)),
                        ),
                      ),
                      TextFieldContainerWidget(
                        child: TextFormField(
                          controller: _emailController,
                          style: const TextStyle(fontSize: 20),
                          cursorColor: Colors.red,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.email,
                              color: Color(0xff62020a),
                            ),
                            hintText: "Email",
                            border: InputBorder.none,
                          ),
                          validator: (String? val) {
                            final bool isValid =
                                EmailValidator.validate(val!.trim());
                            if (isValid == false) {
                              return "Enter Valid Email Address";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      TextFieldContainerWidget(
                        child: TextFormField(
                          controller: _passwordController,
                          style: const TextStyle(fontSize: 20),
                          cursorColor: Colors.red,
                          obscureText: isPasswordHidden,
                          decoration: InputDecoration(
                              hintText: "Password",
                              icon: Icon(
                                Icons.lock,
                                color: Color(0xff62020a),
                              ),
                              border: InputBorder.none,
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isPasswordHidden = !isPasswordHidden;
                                    });
                                  },
                                  child: Icon(Icons.visibility))),
                          validator: (String? val) {
                            if (val!.trim().length < 7) {
                              return "Enter Valid Password";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      isLoading ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: Container(
                            alignment: Alignment.center,
                            height: 62,
                            decoration: BoxDecoration(
                                color: const Color(0xff62020a),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1,
                            )),
                      ) :
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: GestureDetector(
                          onTap: () async {
                            bool formValid = _formKey.currentState!.validate();
                            if (formValid == false) {
                              return;
                            }
                            
                            setState(() {
                              isLoading = true;
                            });
                            bool res = await _userProvider.signIn(
                                _emailController.text.trim(),
                                _passwordController.text.trim());

                            print(res);
                            
                            // if(res == true){
                            //   Get.to(()  => )
                            // }

                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: 62,
                              decoration: BoxDecoration(
                                  color: const Color(0xff62020a),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: const Text(
                                "Sign in",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )),
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
