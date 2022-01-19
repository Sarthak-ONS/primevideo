import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFirestoreApi {
  final CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection('Users');

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirebaseFirestoreApi({String? userID}) {
    checkIfProfileIsAlreadyPresent(userID!);
  }

  Future checkIfProfileIsAlreadyPresent(String userID) async {
    final isPresent = await _firebaseFirestore.doc(userID).get();

    if (isPresent.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future createProfileInDatabase(String? userID) async {
    if (await checkIfProfileIsAlreadyPresent(userID!)) return;

    try {
      _firebaseFirestore.doc(userID).set(
        {
          "name": _firebaseAuth.currentUser!.displayName,
          "email": _firebaseAuth.currentUser!.email,
          "photoUrl": _firebaseAuth.currentUser!.photoURL,
          "isUserVerified": true,
          "listOfMoviesForWatchList": [],
          "listofMoviesForContinueWatching": [],
        },
      ).then((value) => print("Successfully Created user Profile"));
    } catch (e) {
      print("Error creating new user Profile");
      print(e);
    }
  }
}
