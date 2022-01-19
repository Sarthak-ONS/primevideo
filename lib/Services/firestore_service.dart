import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

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
          "listOfMoviesForWatchList": [],
          "listofMoviesForContinueWatching": [],
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
      _firebaseFirestore.doc(_firebaseAuth.currentUser!.uid).update({
        "listOfMoviesForWatchList": FieldValue.arrayUnion([
          {
            "id": movieID,
            "name": name,
            "poster_path": posterpath,
            "backdrop_path": backdroppath,
            "overview": overview,
            "tagline": tagline,
            "duration": duration,
            "release_date": date
          },
        ]),
      }).then((value) => print("Added to watch list"));
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

  Future removeFromwatchList(
    String movieID,
    String name,
    String posterpath,
    String backdroppath,
    String overview,
    String tagline,
  ) async {
    _firebaseFirestore.doc(_firebaseAuth.currentUser!.uid).update({
      "listOfMoviesForWatchList": FieldValue.arrayRemove(
        [
          {
            "id": movieID,
            "name": name,
            "poster_path": posterpath,
            "backdrop_path": backdroppath,
            "overview": overview,
            "tagline": tagline,
          },
        ],
      ),
    });
  }
}
