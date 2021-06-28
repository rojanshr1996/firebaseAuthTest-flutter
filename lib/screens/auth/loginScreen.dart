import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_test/main.dart';
import 'package:phone_auth_test/screens/auth/phoneVerify.dart';
import 'package:phone_auth_test/screens/auth/signupScreen.dart';
import 'package:phone_auth_test/screens/home/homeScreen.dart';
import 'package:phone_auth_test/services/authenticationServices.dart';
import 'package:phone_auth_test/utilities.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  final AuthenticationServices _auth = AuthenticationServices();
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (_fAuth.currentUser != null) {
      print("User is present");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Container(
        color: Colors.blueGrey[900],
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.blueGrey[900],
            body: Container(
              height: Utilities.screenHeight(context),
              width: Utilities.screenWidth(context),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 30),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Container(
                                child: TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Email field cannot be empty";
                                    }
                                    String p =
                                        r"^([a-zA-Z0-9_\-\+\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]+)$";
                                    RegExp regExp = new RegExp(p);
                                    if (!regExp.hasMatch(value)) {
                                      return "Enter a valid email";
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                      fontSize: 16, color: AppColor.primary),
                                  decoration: const InputDecoration(
                                    hintText: 'What do people call you?',
                                    labelStyle: TextStyle(
                                      color: AppColor.white,
                                    ),
                                    hintStyle: TextStyle(
                                      color: AppColor.muted,
                                    ),
                                    labelText: 'Email',
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColor.primary)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColor.primary)),
                                    disabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColor.muted)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColor.primary)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColor.danger)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Container(
                                child: TextFormField(
                                  controller: passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Password field cannot be empty";
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                      fontSize: 16, color: AppColor.primary),
                                  decoration: const InputDecoration(
                                    hintText: 'What do people call you?',
                                    labelStyle: TextStyle(
                                      color: AppColor.white,
                                    ),
                                    hintStyle: TextStyle(
                                      color: AppColor.muted,
                                    ),
                                    labelText: 'Password',
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColor.primary)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColor.primary)),
                                    disabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColor.muted)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColor.primary)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColor.danger)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Material(
                                        elevation: 2,
                                        color: AppColor.danger,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        child: InkWell(
                                          highlightColor: Colors.transparent,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          onTap: () {
                                            validator();
                                            // Utilities.openActivity(
                                            //     context, HomeScreen());
                                          },
                                          child: Container(
                                            height: 48,
                                            child: Center(
                                              child: Text(
                                                "Login".toUpperCase(),
                                                style: TextStyle(
                                                  color: AppColor.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 25),
                            Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () {
                                  final form = _formKey.currentState;
                                  form!.reset();
                                  Utilities.openActivity(
                                      context, SignupScreen());
                                },
                                child: Text(
                                  "NOT A USER? SIGN UP",
                                  style: TextStyle(
                                      color: AppColor.white, fontSize: 16),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 55, right: 55),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Material(
                                        elevation: 2,
                                        color: AppColor.light,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        child: InkWell(
                                          highlightColor: Colors.transparent,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          onTap: () {
                                            Utilities.openActivity(
                                                context, PhoneVerify());
                                          },
                                          child: Container(
                                            height: 48,
                                            child: Center(
                                              child: Text(
                                                "Phone Signup".toUpperCase(),
                                                style: TextStyle(
                                                  color: AppColor.dark,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  validator() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      print("validated");
      FocusScope.of(context).requestFocus(FocusNode());
      signInUser();
    }
  }

  Future<void> signInUser() async {
    dynamic authResult =
        await _auth.loginUser(emailController.text, passwordController.text);

    if (authResult == null) {
      print("Sign in error");
    } else {
      clearController();
      print("Sign in successful");
      Utilities.openActivity(context, HomeScreen());
    }
  }

  clearController() {
    emailController.clear();
    passwordController.clear();
  }
}
