import 'package:flutter/material.dart';
import 'package:frontend/pages/authentication_screen.dart';
import 'package:frontend/pages/pages_screen.dart';

import '../constants.dart';
import 'explore_screen.dart';
/*
  Responsible for routing between

  The home pages (Explore, Circles, etc.)

  Login/Signup Screen when the session token is not detected (user not authenticated)

  Onboarding Screen which will only happen if the authenticated user is detected as a new user

 */
class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  void initState() {
    super.initState();
  }

  // Need to add logic to determine which of these screens the root screen will display!
  // Widget screen = PagesScreen(); // may want to rename this!
  // Widget screen = OnboardingScreen(); // currently named citycirclefrontpage, will want to decouple onboarding with auth screens

  //Hardcoded
  //Need to determine which screen to display based
  //Onboarding,
  Widget screen = AuthenticationScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screen
    );
  }
}