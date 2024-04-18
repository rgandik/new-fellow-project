import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> postUser ({required String field, required String value}) async {
    var url = 'http://localhost:4000/users';

    if (field == "uid") {
      var response = await http.post(
          Uri.parse(url),
          headers: <String, String>{"Content-Type": "application/json"},
          body: json.encode(<String, String>{
            "uid": currentUser!.uid,
          })
      );
      print(response.statusCode);
    } else {
      var response = await http.post(
          Uri.parse(url),
          headers: <String, String>{"Content-Type": "application/json"},
          body: json.encode(<String, String>{
            "uid": currentUser!.uid,
            field: value
          })
      );
      print(response.statusCode);
    }
  }

  Future<void> signInWithEmailAndPassword({required String email, required String password}) async {
    final response = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

    final user = response.user;

    if (user != null) {
      print(user.uid);
    } else {
      print('Login failed');
    }
  }

  Future<void> createUserWithEmailAndPassword({required String email, required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    postUser(field: "uid", value: currentUser!.uid);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}