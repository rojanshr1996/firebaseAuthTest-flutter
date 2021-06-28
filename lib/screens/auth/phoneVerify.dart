import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_test/main.dart';
import 'package:phone_auth_test/screens/auth/enterPhoneOTP.dart';
import 'package:phone_auth_test/utilities.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
String verificationCode = "";

class PhoneVerify extends StatefulWidget {
  @override
  _PhoneVerifyState createState() => _PhoneVerifyState();
}

class _PhoneVerifyState extends State<PhoneVerify> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final _formKey = new GlobalKey<FormState>();

  // final AuthenticationServices _auth = AuthenticationServices();
  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
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
                                  controller: nameController,
                                  keyboardType: TextInputType.text,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Name value cannot be empty";
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
                                    labelText: 'Name',
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
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Phone field cannot be empty";
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
                                    labelText: 'Phone',
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
      _phoneVerify();
    }
  }

  Future<void> _phoneVerify() async {
    String _phoneNumber = '+977 ${phoneController.text.trim()}';

    phoneVerify(phone: _phoneNumber, name: nameController.text.trim());
  }

  Future? phoneVerify({required String phone, required String name}) async {
    var verifyPhonenumber = auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential? credential) async {
          print("YOOYOY: $credential");
          auth.signInWithCredential(credential!).then((user) async {
            print("This is the credential: $credential");

            await firestore
                .collection('users')
                .doc(auth.currentUser?.uid)
                .set({'name': name, 'phone': phone}, SetOptions(merge: true))
                .then((value) => {
                      Utilities.openActivity(
                          context,
                          EnterPhoneOTP(
                            verificationCode: verificationCode,
                          )),
                    })
                .catchError((onError) {
                  debugPrint("Error saving user: ${onError.toString()}");
                });
          });
        },
        verificationFailed: (FirebaseAuthException error) {
          debugPrint("Error saving user: ${error.message}");
          if (error.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }

          // Handle other errors
        },
        codeSent: (String verificationId, int? resendToken) async {
          print("YOOYOY verification ID: $verificationId");

          verificationCode = verificationId;

          Utilities.openActivity(
              context,
              EnterPhoneOTP(
                verificationCode: verificationCode,
              ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationCode = verificationId;
        },
        timeout: Duration(seconds: 60));

    await verifyPhonenumber;
  }

  clearController() {
    phoneController.clear();
  }
}
