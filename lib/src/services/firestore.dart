import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/challenge.dart';

class FireStoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getUserChallenges(String uid) {
    return _db.collection('users/$uid/challenges').snapshots();
  }

  void addChallenge(String uid, Map<String,Object> challenge) {
    
    _db.collection('users/$uid/challenges').add(challenge);
  }
}
