import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  String _batteryLevel = "Unknown";

  static const platform = const MethodChannel('samples.flutter.dev/battery');

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod("getBatteryLevel");
      batteryLevel = "Battery level at $result %";
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

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
      body: Container(
        height: Utilities.screenHeight(context),
        // width: Utilities.screenWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                child: Text(
                  "$_batteryLevel",
                  style: TextStyle(color: AppColor.white, fontSize: 16),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: ElevatedButton(
                    onPressed: _getBatteryLevel,
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
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColor.primaryDark),
                    ),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("Get Battery"),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
