import 'package:flutter/material.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/pages/first_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  AuthService instance = AuthService();

  // final String _createdUser = "John Deere";

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await instance.signInWithEmailAndPassword(email: (_controllerEmail.text), password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await instance.createUserWithEmailAndPassword(email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
      // return "Error!";
    }
  }

  Widget _title() {
    return const Text('Firebase Auth');
  }

  Widget _entryField(
      String title,
      TextEditingController controller
      ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
      labelText: title),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Error: ? $errorMessage');
  }

  Widget _submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async
      {
        // Future<String> id;
        if (isLogin) {
          signInWithEmailAndPassword();
        } else {
          createUserWithEmailAndPassword();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => First_Page()));
          print("Sus");
          print("Email: ${_controllerEmail.text}");
          print("Password: ${_controllerPassword.text}");
          //get firebase user id
          // print("User ID: $id");
        }
        // isLogin ? signInWithEmailAndPassword() : createUserWithEmailAndPassword();

      },
      child: Text(isLogin ? 'Login' : 'Register'),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register instead' : 'Login instead'),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _entryField('email', _controllerEmail),
            _entryField('password', _controllerPassword),
            _errorMessage(),
            _submitButton(context),
            _loginOrRegisterButton()
          ]
        )
      )
    );
  }
}