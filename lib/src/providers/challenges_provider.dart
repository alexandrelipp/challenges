import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/auth.dart';
import 'package:provider/provider.dart';
import '../services/firestore.dart';
import '../models/challenge.dart';

class ChallengesProvider with ChangeNotifier {
  String _uid;
  final firestoreService = FireStoreService();
  final authService = AuthService();

  Stream<QuerySnapshot> get userChallenges =>
      firestoreService.getUserChallenges(_uid);

  Future<String> signIn(String email, String password) {
    return authService.signInEmail(email, password);
  }

  Future<String> signUp(String email, String password) {
    return authService.signUpEmail(email, password);
  }

  void triggerRebuild(){
    notifyListeners();
  }

  void addChallenge(String title,DateTime date) {
    firestoreService.addChallenge(_uid, {
      'title':title,
      'dueDate':date,
      'startDate':DateTime.now(),
    });
  }

  void signOut() {
    authService.signOut();
  }

  set uid(String newUid) {
    _uid = newUid;
    authService.updateUser();
  }
}
