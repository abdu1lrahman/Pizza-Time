import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isSignedIn = false;

  bool get isSignedIn => _isSignedIn;

  AuthProvider() {
    _auth.authStateChanges().listen(
      (user) {
        _isSignedIn = user != null;
        notifyListeners();
      },
    );
  }
}
