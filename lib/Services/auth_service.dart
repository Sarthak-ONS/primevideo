import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:prime_video/Services/auth_exceptions.dart';
import 'package:prime_video/Services/email_verification_service.dart';

class FirebaseAuthApi {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//Create A User
  Future createUserwithEmailAndPassword(
      String email, String password, String name, context) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.updateDisplayName(name);

      //Send Email Verification Link to the User
      SendEmailVerificationMail()
          .sendEmailVerificaionMail(name: name, email: email, context: context);

      ///
      print(userCredential.user!.email);
    } on FirebaseAuthException catch (e) {
      CustomAuthExceptions().handleAuthExceptions(e.code);
    }
  }

  // Sign In A User
  Future signIn() async {}

  //Forgot Password
  Future forgorPassword() async {}

  //Send Email Verification Link

  Future verifyEmail() async {}
}
