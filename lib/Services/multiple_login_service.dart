import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckForMultiPleLogins {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future checkNoofTokensinDatabase() async {
    try {
      final res = await _firebaseAuth.currentUser!.getIdTokenResult();
      print(res.token);
      DocumentSnapshot documentSnapshot = await _firebaseFirestore
          .collection('Users')
          .doc(_firebaseAuth.currentUser!.uid)
          .get();

      final tokenFromDatabase = documentSnapshot.get("loginTokens");

      if (tokenFromDatabase.toString() == res.token) {
        print(true);
        return true;
      } else {
        print(false);
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

//TODO: Clear HIve Database After Logout.