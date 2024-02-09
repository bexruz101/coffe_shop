import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/services/firestore_database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserFirebase? _userFromFirebaseUser(User? user) {
    return user != null ? UserFirebase(uid: user.uid) : null;
  }

  Stream<UserFirebase?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print('FIRE ERROR:${e.toString()}');
      return null;
    }
  }

  Future registerWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await DatabaseService(uid: result.user!.uid)
          .updateUserData(sugars: '0', name: 'new member', strength: 100);
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
