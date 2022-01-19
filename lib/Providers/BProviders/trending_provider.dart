import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MovieProvider extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  get trendingMedia => _firebaseFirestore.collection('Trending').get();

  get topRatedMedia => _firebaseFirestore.collection('Top Rated').get();

  get recommendedMedia => _firebaseFirestore.collection('Recommended').get();

  get upcomingMedia => _firebaseFirestore.collection('Upcoming').get();

  get nowPlaying => _firebaseFirestore.collection('Now Playing').get();

  get singleMovieProvider =>
      _firebaseFirestore.collection('AllMovies').doc().get();

  returnSingleMovieProviderFuture(String id) {
    return _firebaseFirestore.collection('AllMovies').doc(id).get();
  }

  get watchListMovieProvider => _firebaseFirestore
      .collection('Users')
      .doc(_firebaseAuth.currentUser!.uid)
      .get();
}
