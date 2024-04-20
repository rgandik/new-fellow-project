import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/pages/authentication_screen.dart';
import 'package:frontend/widgets/myEntryField.dart';
import 'package:frontend/pages/onboarding/onboarding_achievements.dart';

import 'package:frontend/widgets/myButton.dart';

import 'package:frontend/pages/pages_screen.dart';

class OnboardingDone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.only(top: 94.0),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/AllSetChecklist.svg',
                    height: 242,
                    width: 100,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: 150, // Adjust this value to control the line wrapping
                  height: 126,
                  alignment: Alignment.center,
                  child: Text(
                    "You Are" + '\n' + "All Set!",
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      overflow: TextOverflow.visible, // This forces the text to wrap
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: myButton(
                  onPressed: () {
                    print("Start Finding Circles Pressed");
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const PagesScreen()),
                    // );
                    // Need to let the root screen know to re-check if finished onboarding
                    // Maybe change the futurebuilder to instead be based on the value of some provider that stores user information
                  },
                  text: 'Start Finding Circles',
                  // child: Text('Start Finding Circles'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

