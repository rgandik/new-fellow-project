import 'package:flutter/material.dart';
import 'package:frontend/pages/onboarding/onboarding_location.dart';
import 'package:frontend/pages/profile_screen.dart';
import 'package:frontend/widgets/myButton.dart';
import 'package:frontend/constants.dart';
import 'login_screen.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100),
                topRight: Radius.circular(100)
              )
            ),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const Spacer(),
                SizedBox(
                  width: 333,
                  height: 56,
                  child: OutlinedButton(
                    // Change ElevatedButton to OutlinedButton
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(login: false)));
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).secondaryHeaderColor,
                      side: BorderSide(
                        color: Theme.of(context).secondaryHeaderColor,
                      ), // Set border color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10), // Set border radius
                      ),
                      padding: EdgeInsets.zero, // Remove padding
                    ),
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ), // Set text color
                    ),
                  ),
                ),
                const SizedBox(height: 17),
                SizedBox(
                  width: 333,
                  height: 56,
                  child: OutlinedButton(
                    // Change ElevatedButton to OutlinedButton
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(login: true)));
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Theme.of(context).secondaryHeaderColor,
                      ), // Set border color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10), // Set border radius
                      ),
                      padding: EdgeInsets.zero, // Remove padding
                    ),
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ), // Set text color
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                      bottom:
                      100.0), // Adjust the value to move the button down
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 600,
                color: Theme.of(context).primaryColor,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'City Circle',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Find your circle',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
