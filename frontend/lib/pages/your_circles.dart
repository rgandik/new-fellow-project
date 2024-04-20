import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../constants.dart';
import 'created_circles.dart';
import 'joined_circles.dart';

class YourCircles extends StatefulWidget {
  @override
  YourCirclesState createState() => YourCirclesState();
}

class YourCirclesState extends State<YourCircles> {
  final PageController _pageController = PageController(initialPage: 0);
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      JoinedCircles(),
      CreatedCircles()
    ];
  }

  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Circles'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: ToggleSwitch(
              minWidth: Constants.width * .9,
              cornerRadius: 20.0,
              activeBgColors: const [[Constants.myOrange], [Constants.myOrange]],
              activeFgColor: Constants.myWhite,
              inactiveBgColor: Constants.myGray,
              inactiveFgColor: Constants.mySilver,
              initialLabelIndex: _selectedIndex,
              totalSwitches: 2,
              labels: const ['My Circles', 'Created Circles'],
              radiusStyle: true,
              onToggle: (index) {
                print(index);
                _selectedIndex = index!;
                _pageController.animateToPage(_selectedIndex,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeIn);
              }
            )
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: Constants.height
                  ),
                  child: PageView(
                      controller: _pageController,
                      children: _pages,
                      onPageChanged: (int index) {
                        setState(() => _selectedIndex = index);
                      },
                      physics: const ScrollPhysics()
                  ),
                )
              ]
            )
          )
        ]
      )
    );
  }
}