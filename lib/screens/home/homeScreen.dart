import 'package:flutter/material.dart';
import 'package:phone_auth_test/main.dart';
import 'package:phone_auth_test/screens/auth/loginScreen.dart';
import 'package:phone_auth_test/services/authenticationServices.dart';
import 'package:phone_auth_test/utilities.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthenticationServices _auth = AuthenticationServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkAccent,
      appBar: AppBar(
        backgroundColor: AppColor.primaryDark,
        title: Text(
          "Home Screen",
          style: TextStyle(color: AppColor.primary),
        ),
        automaticallyImplyLeading: false,
        actions: [
          // IconButton(
          //     icon: Icon(Icons.logout),
          //     color: AppColor.primary,
          //     onPressed: () {
          //       print("log out");
          //     })

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                print("Log out");
                await _auth.signOut().then((result) {
                  print("This is signout: $result");
                  if (result != "error") {
                    Utilities.removeStackActivity(context, LoginScreen());
                  }
                });
              },
              // style:
              // ElevatedButton.styleFrom(
              //   primary: AppColor.primaryDark, // background
              //   onPrimary: Colors.white, // foreground
              // ),
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered))
                        return AppColor.primaryDarkAccent;
                      if (states.contains(MaterialState.focused) ||
                          states.contains(MaterialState.pressed))
                        return AppColor.primaryDarkAccent;
                      return AppColor
                          .primaryDarkAccent; // Defer to the widget's default.
                    },
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColor.primaryDark)),
              child: Icon(Icons.logout),
            ),
          ),
        ],
      ),
    );
  }
}
