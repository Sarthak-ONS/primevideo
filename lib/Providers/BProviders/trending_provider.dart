import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TrendingMovieProvider extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  get trendingMedia => _firebaseFirestore.collection('Trending').get();
}
