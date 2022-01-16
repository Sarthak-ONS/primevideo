import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthApi {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//Create A User
  Future createUserwithEmailAndPassword() async {
    try {
      //

    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  // Sign In A User
  Future signIn() async {}

  //Forgot Password
  Future forgorPassword() async {}

  //Send Email Verification Link

  Future verifyEmail() async {}
}
