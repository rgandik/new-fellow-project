import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/widgets/myEntryField.dart';
import 'package:frontend/pages/WhenBirthday.dart';

class ShareYourAchievements extends StatelessWidget {
  const ShareYourAchievements({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SvgPicture.asset(
                    'assets/icons/progress2.svg',
                    height: 100,
                    width: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ), // Default style
                      children: [
                        TextSpan(
                          text: "Share Your",
                        ),
                        TextSpan(
                          text: " Achievements!",
                          style: TextStyle(color: Constants.myOrange),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'This is to connect to people who are similar to you!',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Internship Company Name',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      myEntryField(), // Assuming this is your custom text input widget
                      const SizedBox(height: 30),
                      Text(
                        'School Name',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      myEntryField(), // Assuming this is your custom text input widget
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Add the buttons row here
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle left button press
                    print('Left button pressed');
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset(
                    'assets/icons/Back Arrow.svg',
                    height: 65, // Adjust the height as neededd
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    // Handle right button press
                    print('Right button pressed');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WhenBirthday()),
                    );
                  },
                  child: SvgPicture.asset(
                    'assets/icons/Front Arrow.svg',
                    height: 65, // Adjust the height as needed
                    // width: , // Adjust the width as needed
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
