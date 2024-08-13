import 'package:firebase_auth/firebase_auth.dart';

class Auth{


  userlogin() async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInAnonymously();

      print("Signed in with temporary account.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }

  }

}