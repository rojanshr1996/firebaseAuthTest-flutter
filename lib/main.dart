import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_test/screens/auth/loginScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone Authentication',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: AppColor.primary,
        highlightColor: Colors.transparent,
        splashColor: AppColor.primaryDarkAccent,
      ),
      home: LoginScreen(),
    );
  }
}

class AppColor {
  // static const primary = Color(0xff263238);
  static const primary = Color(0xffe1e2f0);
  static const primaryDark = Color(0xff263238);
  static const primaryDarkAccent = Color(0xff3B4D56);
  static const danger = Color(0xffff2e59);

  static const light = Color(0xffe1e2f0);
  static const white = Color(0xffffffff);
  static const lightAccent = Color(0xffeaebf9);

  static const dark = Color(0xff212230);
  static const darkAccent = Color(0xff3a3b49);

  static const shadowDark = Color(0xff1a1b29);
  static const shadowLight = Color(0xffd1d2e0);

  static const muted = Color(0xff8a8b99);
}
