import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/challenge.dart';

class FireStoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getUserChallenges(String uid) {
    return _db.collection('users/$uid/challenges').snapshots();
  }

  Future<void> addChallenge(String uid, String title) async {
    print('challenged added');
    try {
      await _db.collection('users/$uid/challenges').add({
        'title': title,
      });
    } catch (e) {
      throw (e);
    }
  }
}
