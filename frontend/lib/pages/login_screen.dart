import 'package:flutter/material.dart';
import 'package:frontend/pages/authentication_screen.dart';
import 'package:frontend/widgets/myButton.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:frontend/widgets/myButton.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool _rememberMe = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Hi, Welcome!',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 32.0),
            Text(
              'Email address',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),

            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Your email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Password',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
            TextField(
              controller: _passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
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
                Text('Remember me'),
                Spacer(),
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
            SizedBox(height: 32.0),
            Align(
              alignment: Alignment.center,
              child: myButton(
                onPressed: () {
                  print("Log in button pressed");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AuthenticationScreen()),
                  );
                },
                text: 'Log in',
                // child: Text('Start Finding Circles'),
              ),
            ),
            SizedBox(height: 200.0),
            Row(
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
            SizedBox(height: 16.0),
            Center(
              child: Container(
                width: 200.0, // Set the width as needed
                height: 70.0, // Set the height as needed
                // decoration: BoxDecoration(
                //   border: Border.all(
                //     color: Colors.black, // Set the border color as needed
                //     width: 2.0, // Set the border width as needed
                //   ),
                // ),
                child: Center(
                  child: SignInButton(
                    Buttons.google,
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  // Add functionality for sign up
                },
                child: Text(
                  "Don't have an account? Sign up",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
