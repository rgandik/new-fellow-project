import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();


  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  // Method to set error message
  void setErrorMessage(String? message) {
    _errorMessage = message;
  }

  Future<void> postUser({required String field, required String value}) async {
    var url = 'http://localhost:4000/users';

    if (field == "uid") {
      var response = await http.post(Uri.parse(url),
          headers: <String, String>{"Content-Type": "application/json"},
          body: json.encode(<String, String>{
            "uid": currentUser!.uid,
          }));
      print(response.statusCode);
    } else {
      var response = await http.post(Uri.parse(url),
          headers: <String, String>{"Content-Type": "application/json"},
          body: json
              .encode(<String, String>{"uid": currentUser!.uid, field: value}));
      print(response.statusCode);
    }
  }

  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
    Function(String)? onError,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return true; // Login successful
    } catch (e) {
      String errorMessage = e.toString();
      _errorMessage = errorMessage.replaceAll(RegExp(r'\s*\[.*?\]\s*'), '');

      print("signin error " + _errorMessage!);
      if (onError != null) {
        onError(_errorMessage!);
      }
      return false; // Login failed
    }
  }

  Future<bool> createUserWithEmailAndPassword({
    required String email,
    required String password,
    Function(String)? onError,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return true; // User creation successful
    } catch (e) {
      String errorMessage = e.toString();
      _errorMessage = errorMessage.replaceAll(RegExp(r'\s*\[.*?\]\s*'), '');

      print("login error " + _errorMessage!);
      if (onError != null) {
        onError(_errorMessage!);
      }
      return false; // User creation failed
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
