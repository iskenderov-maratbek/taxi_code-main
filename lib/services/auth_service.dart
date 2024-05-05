import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;

  Future<bool> checkAuth() async {
    return false;
  }

  void logout(context) {
    Navigator.pushNamed(context, '/auth');
    _auth.signOut();

    notifyListeners();
  }

  Future<void> signInWithEmailAndPassword(
      context, String email, String password) async {
    UserCredential credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (credential.user != null) {
      saveAuthData(credential);
      notifyListeners();
    } else {
      print('error');
    }
  }

  saveAuthData(credential) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', credential.user!.uid);
  }

  Future<void> createWithEmailAndPassword(String email, String password) async {
    UserCredential credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (credential.user != null) {
      saveAuthData(credential);
      notifyListeners();
    } else {
      print('error');
    }
    notifyListeners();
  }

  Future<void> signOut(context) async {
    await _auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushNamed(context, '/auth');
    notifyListeners();
  }
}
