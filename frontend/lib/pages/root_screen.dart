import 'package:flutter/material.dart';
import 'package:frontend/pages/authentication_screen.dart';
import '../providers/profile_provider.dart';
import 'onboarding.dart';
import 'onboarding/onboarding_location.dart';
import 'package:frontend/pages/pages_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  RootScreenState createState() => RootScreenState();
}

class RootScreenState extends State<RootScreen> {
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
      return true;
    } else {
      return false;
    }
  }

  Widget screen = const AuthenticationScreen();

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.loggedIn()) {
      screen = FutureBuilder<bool>(
        future: checkOnboardingCompletion(authProvider.uid()!),
        builder: (context, snapshot) {
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
      screen = const AuthenticationScreen();
    }
    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);
    if (profileProvider.onboarded()) {
      screen = FutureBuilder<bool>(
        future: checkOnboardingCompletion(authProvider.uid()!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.data ?? false) {
                return const PagesScreen();
              } else {
                return OnboardingLocation();
              }
            }
          }
      );
    }
    return Scaffold(
        body: screen
    );
  }
}