import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prime_video/private_variable.dart';

class FirebaseFirestoreApi {
  final CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection('Users');

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirebaseFirestoreApi({String? userID}) {
    // checkIfProfileIsAlreadyPresent(userID!);
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
        },
      ).then((value) => print("Successfully Created user Profile"));
    } catch (e) {
      print("Error creating new user Profile");
      print(e);
    }
  }

  Future addMovietoWatchList(String movieID, String name, String posterpath,
      String backdroppath, String overview, String duration, String date,
      {String? tagline = ""}) async {
    try {
      DocumentReference ref = await _firebaseFirestore
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('Watchlist')
          .add({
        "id": movieID,
        "name": name,
        "poster_path": posterpath,
        "backdrop_path": backdroppath,
        "overview": overview,
        "tagline": tagline,
        "duration": duration,
        "release_date": date,
        "docID": "",
        "loginTokens": []
      });

      _firebaseFirestore
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('Watchlist')
          .doc(ref.id)
          .update({"docID": ref.id}).then(
        (value) => print("Successfulyy added and updated DOC ID"),
      );
    } catch (e) {
      print("Error adding movie to watchlist");
      print(e);
    }
  }

  Future addMovietoContinueWatchingList(
    String movieID,
    String name,
    String posterpath,
    String backdroppath,
    String overview,
    String tagline,
    String duration,
  ) async {
    try {
      _firebaseFirestore.doc(_firebaseAuth.currentUser!.uid).update({
        "listofMoviesForContinueWatching": FieldValue.arrayUnion([
          {
            "id": movieID,
            "name": name,
            "poster_path": posterpath,
            "backdrop_path": backdroppath,
            "overview": overview,
            "tagline": tagline,
            "duration": duration
          },
        ]),
      });
    } catch (e) {
      print("Error adding movie to Continewatchlist");
      print(e);
    }
  }

  Future removeFromwatchList(String docID) async {
    print(docID);
    try {
      _firebaseFirestore
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('Watchlist')
          .doc(docID)
          .delete()
          .then((value) => print("Scuuessfuly deleted Movie From watchlist"));
    } catch (e) {
      print("Eror Deleting From watchlist");
      print(e);
    }
  }

  Future checkifMovieisAlreadyWatchListed(String movieID) async {
    try {
      final isWatchListed = await _firebaseFirestore
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('Watchlist')
          .where("id", isEqualTo: movieID)
          .get();
      if (isWatchListed.docs.isNotEmpty) {
        print("Movie is watchlisted");
        return true;
      } else {
        print("Movie is not watchlisted");
        return false;
      }
    } catch (e) {
      print("Eror From checkifMovieisAlreadyWatchListed");
    }
  }

  Future saveCurrentUserTokenttoDatabase(String encryptedToken) async {
    try {
      _firebaseFirestore.doc(_firebaseAuth.currentUser!.uid).update(
        {
          "loginTokens": FieldValue.arrayUnion([encryptedToken]),
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future checkTokens() async {
    _firebaseAuth.currentUser!.getIdTokenResult();
    try {
      DocumentSnapshot snapshot =
          await _firebaseFirestore.doc(_firebaseAuth.currentUser!.uid).get();

      final loginTokenLength = await snapshot.get("loginTokens").length;

      if (loginTokenLength > 1) {
        return "More Logins";
      } else {
        return "Go Login";
      }
    } catch (e) {
      print("Eror Checking Tokens");
      print(e);
    }
  }
}
