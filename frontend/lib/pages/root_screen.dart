import 'package:flutter/material.dart';
import 'package:frontend/pages/authentication_screen.dart';
import 'package:frontend/pages/login_screen.dart';
import 'package:frontend/pages/pages_screen.dart';
import 'package:frontend/services/auth_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

  late Map<String, dynamic> userData;
  void checkOnboardingCompletion() async {
    var url = 'https://new-fellow-project.vercel.app/users';

    final response = await http.get(Uri.parse('$url/AewbSSalf9fBnjkrKCVZBC0kDM03'));
    if (response.statusCode == 200) {
      if (mounted) {
        setState(() => userData = Map<String, dynamic>.from(jsonDecode(response.body)));
        print(userData);
      }
    } else {
      throw Exception('Error locating user');
    }
  }

  Widget screen = AuthenticationScreen();

  /*if (currentUser.uid != null) {
    checkOnboardingCompletion();

    if (userData.interests != []) {

    }
  } else {
    setState(() => screen = AuthenticationScreen());
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screen
    );
  }
}