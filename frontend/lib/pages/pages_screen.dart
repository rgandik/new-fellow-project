import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/pages/joined_circles.dart';
import 'package:frontend/pages/profile_screen.dart';
import '../constants.dart';
import 'explore_screen.dart';
import 'your_circles.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
/*
  Responsible for routing between the home pages:
    Explore
    Your Circles base page (carrier for Joined Circles and Created Circles)
    Profile
 */
class PagesScreen extends StatefulWidget {
  const PagesScreen({Key? key}) : super(key: key);

  @override
  PagesScreenState createState() => PagesScreenState();
}

class PagesScreenState extends State<PagesScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      ExploreScreen(),
      YourCircles(),
      ProfileScreen(),
    ];
  }

  int _selectedIndex = 0;

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
        children: _pages,
        onPageChanged: (int index) {
          setState(() => _selectedIndex = index);
        },
        physics: const NeverScrollableScrollPhysics()
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Constants.myOrange,
        unselectedItemColor: Constants.myGray,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          /*BottomNavigationBarItem(
            icon: Icon(Icons.name),
            label: 'Name',
          ),*/
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.fromString('google-circles')),
            label: "Circles"
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Profile"
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}