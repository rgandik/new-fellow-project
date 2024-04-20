import 'package:flutter/material.dart';
import 'package:frontend/pages/authentication_screen.dart';
import 'package:frontend/pages/login_screen.dart';
import 'package:frontend/pages/pages_screen.dart';
import 'package:frontend/services/auth_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/auth_provider.dart';
import 'explore_screen.dart';
import 'onboarding/onboarding_location.dart';
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

  Future<bool> checkOnboardingCompletion(String uid) async {
    var url = 'https://new-fellow-project.vercel.app/users';

    final response = await http.get(Uri.parse('$url/$uid'));
    if (response.statusCode == 200 && response.body != "") {
      print("Reached true");
      return true;
    } else {
      print("Reached false");
      return false;
    }
  }

  Widget screen = const AuthenticationScreen();

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    print("Rerender");
    print(authProvider.loggedIn());
    if (authProvider.loggedIn()) {
      print("here");
      screen = FutureBuilder<bool>(
        future: checkOnboardingCompletion(authProvider.uid()!),
        builder: (context, snapshot) {
          print("building");
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if(snapshot.data ?? false) {
              return const PagesScreen();
            } else {
              return OnboardingLocation();
            }
          }
        }
      );
    } else {
      print("yoo");
      screen = const AuthenticationScreen();
    }
    print(screen);
    return Scaffold(
        body: screen
    );
  }
}