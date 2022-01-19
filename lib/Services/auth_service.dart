import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:prime_video/Providers/BProviders/current_user_provider.dart';
import 'package:prime_video/Screens/home_screen.dart';
import 'package:prime_video/Services/auth_exceptions.dart';
import 'package:prime_video/Services/email_verification_service.dart';
import 'package:prime_video/Services/firestore_service.dart';
import 'package:prime_video/routes.dart';
import 'package:provider/provider.dart';

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

      await FirebaseFirestoreApi()
          .createProfileInDatabase(userCredential.user!.uid);

      ///
      print(userCredential.user!.email);
    } on FirebaseAuthException catch (e) {
      CustomAuthExceptions().handleAuthExceptions(e.code, context);
    }
  }

  // Sign In A User
  Future signIn({
    String? email,
    String? password,
    BuildContext? context,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email!, password: password!);
      print(userCredential);
      //Change Credential Provider
      //Go to Home Page
      Navigator.of(context!).pushAndRemoveUntil(
          createRoute(const HomeScreen()), (route) => false);
    } on FirebaseAuthException catch (e) {
      CustomAuthExceptions().handleAuthExceptions(e.code, context);
    } catch (e) {
      print("/../");
      print(e);
    }
  }

  //Forgot Password
  Future forgorPassword({String? email, BuildContext? context}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(
        email: email!,
      );
    } on FirebaseAuthException catch (e) {
      CustomAuthExceptions().handleAuthExceptions(e.code, context!);
    }
  }

  Future autoLoginChangeDetials(context) async {
    Provider.of<CurrentUserProvider>(context).changeUserDetails(
      _firebaseAuth.currentUser!.email!,
      _firebaseAuth.currentUser!.displayName!,
      _firebaseAuth.currentUser!.photoURL == null
          ? ""
          : _firebaseAuth.currentUser!.photoURL!,
    );
  }

//Signout
  Future signout() async {
    try {
      _firebaseAuth.signOut();
    } catch (e) {
      print("Error During Singout");
      print(e);
    }
  }
}
