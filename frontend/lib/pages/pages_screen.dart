import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/pages/your_circles.dart';
import '../constants.dart';
import 'explore_screen.dart';
import 'login_register_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
/*
  Responsible for routing between

  The home pages (Explore, Circles, etc.)

  Login/Signup Screen when the session token is not detected (user not authenticated)

  Onboarding Screen which will only happen if the authenticated user is detected as a new user

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
      YourCirclesPage(),
      const LoginPage()
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