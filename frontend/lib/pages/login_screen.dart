import 'package:flutter/material.dart';
import 'package:frontend/widgets/myButton.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/widgets/userInputField.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key, required this.login}) : super(key: key);

  bool login;

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool _rememberMe = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            minWidth: MediaQuery.of(context).size.width,
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80.0),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hi, Welcome!',
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  const Text(
                    'Email Address',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  userInputField(
                    controller: _emailController,
                    hintText: 'janedoe@gmail.com',
                  ),
                  SizedBox(height: 16.0),
                  const Text(
                    'Password',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  userInputField(
                    controller: _passwordController,
                    hintText: 'supersecretpassword',
                    obscureText: _obscureText,
                    suffixIcon: IconButton(
                      icon: Icon(!_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                      ),
                      const Text('Remember me'),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // Add functionality for forgot password
                          // print()
                          print(_emailController.text);
                          print(_passwordController.text);
                        },
                        child: Text('Forgot password?'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32.0),
                  Align(
                    alignment: Alignment.center,
                    child: myButton(
                      onPressed: () async {
                        print(widget.login
                            ? "Log in button pressed"
                            : "Sign up button pressed");
                        print("authserivce emssage" +
                            AuthService().errorMessage.toString());

                        if (widget.login) {
                          bool loggedIn =
                              await AuthService().signInWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  onError: (errorMessage) {
                                    setState(() {
                                      AuthService()
                                          .setErrorMessage(errorMessage);
                                    });
                                  });
                          if (loggedIn) {
                            Navigator.pop(
                                context); // Pop only if login is successful
                          }
                        } else {
                          bool signedUp = await AuthService()
                              .createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  onError: (errorMessage) {
                                    setState(() {
                                      AuthService()
                                          .setErrorMessage(errorMessage);
                                    });
                                  });
                          if (signedUp) {
                            Navigator.pop(
                                context); // Pop only if sign up is successful
                          }
                        }
                      },
                      text: widget.login ? 'Log in' : 'Sign up',
                      width: 3000.0,
                    ),
                  ),
                  SizedBox(height: 200.0),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('Or with'),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: Container(
                      width: 200.0, // Set the width as needed
                      height: 70.0, // Set the height as needed
                      child: Center(
                        child: SignInButton(
                          Buttons.google,
                          onPressed: () {
                            //REMOVE THIS LATER ---------------------------
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        setState(() => widget.login = !widget.login);
                      },
                      child: Text(
                        widget.login
                            ? "Don't have an account? Sign up"
                            : "Already have an account? Log in",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // Display error message from AuthService
                  if (AuthService().errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        AuthService().errorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
