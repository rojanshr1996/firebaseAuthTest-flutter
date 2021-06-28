import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Registration with email and password

  Future createNewUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('${e.message}');
      } else if (e.code == 'email-already-in-use') {
        print('${e.message}');
      }
    } catch (e) {
      print(e);
    }
  }

  //Sign in with email and password
  Future loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('${e.message}');
      } else if (e.code == 'wrong-password') {
        print('${e.message}');
      }
    } catch (e) {
      print(e);
    }
  }

  //sign out
  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print("$e");
      return "error";
    }
  }

  // Future? phoneVerify({required String phone, required String name}) {
  //   try {
  //     var verifyPhonenumber = _auth.verifyPhoneNumber(
  //       phoneNumber: phone,
  //       verificationCompleted: (PhoneAuthCredential? credential) async {
  //         _auth.signInWithCredential(credential!).then((user) async {
  //           print("This is the credential: $credential");

  //           await _firestore
  //               .collection('users')
  //               .doc(_auth.currentUser?.uid)
  //               .set({
  //             'name': name,
  //             'phone': phone
  //           }, SetOptions(merge: true)).catchError((onError) => {
  //                     debugPrint("Error saving user: ${onError.toString()}"),
  //                   });
  //         });
  //       },
  //       verificationFailed: (FirebaseAuthException error) {
  //         debugPrint("Error saving user: ${error.message}");
  //         if (error.code == 'invalid-phone-number') {
  //           print('The provided phone number is not valid.');
  //         }

  //         // Handle other errors
  //       },
  //       codeSent: (String verificationId, int? resendToken) async {
  //         String smsCode = 'xxxx';
  //         // PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //         //     verificationId: verificationId, smsCode: smsCode);

  //         // // Sign the user in (or link) with the credential
  //         // await _auth.signInWithCredential(credential);

  //         verifi
  //       },
  //       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
  //     );

  //     return verifyPhonenumber;
  //   } catch (e) {
  //     print("$e");
  //   }
  // }
}
