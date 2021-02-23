import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  var _auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    await _auth.signOut();
  }

  void updateUser() {
    _auth = FirebaseAuth.instance;
  }

  Future<String> signInEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'success';
    } on FirebaseAuthException catch (e) {
      String _message;
      switch (e.code) {
        case 'user-not-found':
        case 'wrong-password':
          _message = 'Unable to log you in\nPlease try again';
          break;
        case 'user-disabled':
          _message = 'This user has been disabled';
          break;
        default:
          _message = 'Unable to connect\nPlease check your internet connection';
      }
      return _message;
    }
  }

  Future<String> signUpEmail(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'success';
    } on FirebaseAuthException catch (e) {
      String _message;
      switch (e.code) {
        case 'email-already-in-use':
          _message =
              'This email is alredy in use\nPlease try again with a different email';
          break;
        case 'invalid-email':
          _message =
              'This email is not valid\nPlease try again with a valid email';
          break;
        case 'weak-password':
          _message =
              'This password is too weak\nPlease try again with a stronger password';
          break;
        default:
          _message = 'Unable to connect\nPlease check your internet connection';
      }
      return _message;
    }
  }
}
