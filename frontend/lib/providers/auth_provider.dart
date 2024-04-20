import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  bool _loggedIn = false;
  late String? _uid;

  // bool get loggedIn => _loggedIn;

  bool loggedIn() {
    return _loggedIn;
  }

  String? uid() {
    return _uid;
  }

  AuthProvider() {
    listenToAuth();
  }

  Future<void> listenToAuth() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      print(user);
      if (user == null) {
        _loggedIn = false;
        _uid = null;
      } else {
        _loggedIn = true;
        _uid = FirebaseAuth.instance.currentUser!.uid;
      }
      print(_loggedIn);
      notifyListeners();
    });
  }
}