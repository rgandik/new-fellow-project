import 'package:flutter/material.dart';
import 'package:frontend/pages/onboarding/onboarding_achievements.dart';
import 'onboarding/onboarding_birthday.dart';
import 'onboarding/onboarding_done.dart';
import 'onboarding/onboarding_interests.dart';
import 'onboarding/onboarding_location.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      OnboardingLocation(),
      OnboardingAchievements(),
      OnboardingBirthday(),
      OnboardingInterests(),
      OnboardingDone()
    ];
  }

  int _selectedIndex = 0;

  onboardingMove(int index) {
    _onItemTapped(index);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(_selectedIndex,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() => _selectedIndex = index);
        },
        physics: const NeverScrollableScrollPhysics(),
        children: _pages
      )
    );
  }
}