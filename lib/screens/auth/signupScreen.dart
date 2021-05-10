import 'package:flutter/material.dart';
import 'package:phone_auth_test/main.dart';
import 'package:phone_auth_test/services/authenticationServices.dart';
import 'package:phone_auth_test/utilities.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = new GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String countryCode = "+977";

  AuthenticationServices _auth = AuthenticationServices();

  // FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blueGrey[900],
          body: Container(
            height: Utilities.screenHeight(context),
            width: Utilities.screenWidth(context),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
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
                                  controller: addressController,
                                  keyboardType: TextInputType.text,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Address value cannot be empty";
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
                                    labelText: 'Address',
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
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: AppColor.white),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Center(
                                        child: Text(
                                          "$countryCode",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: AppColor.primary),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    flex: 4,
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
                                            fontSize: 16,
                                            color: AppColor.primary),
                                        decoration: const InputDecoration(
                                          hintText: 'What do people call you?',
                                          labelStyle: TextStyle(
                                            color: AppColor.white,
                                          ),
                                          hintStyle: TextStyle(
                                            color: AppColor.muted,
                                          ),
                                          labelText: 'Phone Number',
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColor.primary)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColor.primary)),
                                          disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColor.muted)),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColor.primary)),
                                          errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColor.danger)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
                                  style: TextStyle(
                                      fontSize: 16, color: AppColor.primary),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Password field cannot be empty";
                                    }
                                    return null;
                                  },
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
                                          },
                                          child: Container(
                                            height: 48,
                                            child: Center(
                                              child: Text(
                                                "CREATE ACCOUNT",
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
                  )
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
      createUser();
    }
  }

  void createUser() async {
    dynamic result = await _auth.createNewUser(
        emailController.text.trim(), passwordController.text);

    if (result == null) {
      print("Email is not valid");
    } else {
      print(result.toString());
      clearController();
      Utilities.closeActivity(context);
    }
  }

  clearController() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    phoneController.clear();
    addressController.clear();
  }
}
