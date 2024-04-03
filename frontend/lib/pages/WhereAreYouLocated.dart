import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/widgets/myEntryField.dart';
import 'package:frontend/pages/ShareYourAchievements.dart';

class WhereAreYouLocated extends StatelessWidget {
  const WhereAreYouLocated({Key? key});

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
                    'assets/icons/progress1.svg',
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
                          text: "Where Are You ",
                        ),
                        TextSpan(
                          text: "Located",
                          style: TextStyle(color: myOrange),
                        ),
                        TextSpan(
                          text: "?",
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Type in the area you will be located during your internship to help us find activities close to you!',
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
                  child: myEntryField(),
                ),
                const SizedBox(height: 20), // Adjust the spacing between the text field and the image
                Image.asset(
                  'assets/icons/WhereAreYouLocatedImage.png', // Replace 'location_image.png' with your image path
                  height: 300, // Adjust the height of the image as needed
                  width: 400, // Make the image take the full width
                  fit: BoxFit.cover, // Adjust the fit of the image as needed
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
                    height: 65, // Adjust the height as needed
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    // Handle right button press
                    print('Right button pressed');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShareYourAchievements()),
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
