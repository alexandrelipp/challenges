import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getUserChallenges(String uid) {
    return _db
        .collection('users/$uid/challenges')
        .orderBy('startDate', descending: true)
        .snapshots();
  }

  void addChallenge(String uid, Map<String, Object> challenge) {
    _db.collection('users/$uid/challenges').add(challenge);
  }

  bool deleteChallenge(String uid, String challengeId) {
    try {
      _db.doc('users/$uid/challenges/$challengeId').delete();
      return true;
    } catch (_) {
      return false;
    }
  }
}
