import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
}
