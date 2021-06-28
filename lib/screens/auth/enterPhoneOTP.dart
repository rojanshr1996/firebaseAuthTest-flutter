import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_test/main.dart';
import 'package:phone_auth_test/screens/auth/phoneVerify.dart';
import 'package:phone_auth_test/screens/auth/signupScreen.dart';
import 'package:phone_auth_test/screens/home/homeScreen.dart';
import 'package:phone_auth_test/services/authenticationServices.dart';
import 'package:phone_auth_test/utilities.dart';

class EnterPhoneOTP extends StatefulWidget {
  final String verificationCode;

  const EnterPhoneOTP({Key? key, required this.verificationCode})
      : super(key: key);
  @override
  _EnterPhoneOTPState createState() => _EnterPhoneOTPState();
}

class _EnterPhoneOTPState extends State<EnterPhoneOTP> {
  TextEditingController otpController = TextEditingController();

  final _formKey = new GlobalKey<FormState>();

  // final AuthenticationServices _auth = AuthenticationServices();

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
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
                                  controller: otpController,
                                  keyboardType: TextInputType.phone,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "OTP field cannot be empty";
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
                                    labelText: 'OTP',
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
                                            dynamic authResult =
                                                auth.signInWithCredential(
                                                    PhoneAuthProvider.credential(
                                                        verificationId:
                                                            verificationCode,
                                                        smsCode: otpController
                                                            .text
                                                            .toString()));

                                            if (authResult == null) {
                                              print("Sign in error");
                                            } else {
                                              clearController();
                                              print("Sign in successful");
                                              Utilities.openActivity(
                                                  context, HomeScreen());
                                            }
                                          },
                                          child: Container(
                                            height: 48,
                                            child: Center(
                                              child: Text(
                                                "Verify".toUpperCase(),
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

  Future<void> signInUser() async {}

  clearController() {
    otpController.clear();
  }
}
