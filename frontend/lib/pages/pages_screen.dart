import 'package:flutter/material.dart';

import '../constants.dart';
import 'explore_screen.dart';
/*
  Responsible for routing between

  The home pages (Explore, Circles, etc.)

  Login/Signup Screen when the session token is not detected (user not authenticated)

  Onboarding Screen which will only happen if the authenticated user is detected as a new user

 */
class PagesScreen extends StatefulWidget {
  const PagesScreen({Key? key}) : super(key: key);

  @override
  _PagesScreenState createState() => _PagesScreenState();
}

class _PagesScreenState extends State<PagesScreen> {
  final PageController _pageController = PageController(initialPage: 1);
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      ExploreScreen(),
      ExploreScreen(),
      ExploreScreen(),
      ExploreScreen(),
      ExploreScreen()
    ];
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(index);
      _pageController.animateToPage(_selectedIndex,
          duration: const Duration(milliseconds:  200),
          curve: Curves.easeIn);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Constants.myTeal,
        unselectedItemColor: Constants.myTeal,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Circles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}