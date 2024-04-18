import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;

  AuthProvider() {
    listenToAuth();
  }

  Future<void> listenToAuth() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        _loggedIn = false;
        // notifyListeners();
      } else {
        _loggedIn = true;
        // notifyListeners();
      }
    });
  }
}