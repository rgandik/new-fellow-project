import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import the flutter_svg package
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
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Spacer(),
                myButton(
                  text: 'Create Account',
                  onPressed: () {
                    // Add your logic here for when the button is pressed
                    print('Create Account button pressed');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen(login: false)));
                  },
                ),
                const SizedBox(height: 17),
                SizedBox(
                  width: 333,
                  height: 56,
                  child: OutlinedButton(
                    // Change ElevatedButton to OutlinedButton
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen(login: true)));

                      // Add your logic here for when the button is pressed
                      print('Log in button pressed');
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ), // Set border color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Set border radius
                      ),
                      padding: EdgeInsets.zero, // Remove padding
                    ),
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
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
                height: 650,
                color: Theme.of(context).primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      // Adjust top padding as needed
                      child: SvgPicture.asset(
                        'assets/icons/CityCircleLogo.svg',
                        // Path to your SVG file
                        height: 200, // Adjust height as needed
                        width: 100, // Adjust width as needed
                        color: Colors.white, // Set color of SVG
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Find Your\nCircle',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 45,
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
