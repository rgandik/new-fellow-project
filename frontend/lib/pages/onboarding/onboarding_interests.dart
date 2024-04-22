import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/pages/authentication_screen.dart';
import 'package:frontend/widgets/myEntryField.dart';
import 'onboarding_done.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OnboardingInterests extends StatefulWidget {
  const OnboardingInterests({Key? key});

  @override
  _OnboardingInterestsState createState() => _OnboardingInterestsState();
}

class _OnboardingInterestsState extends State<OnboardingInterests> {
  final List<String> creativeLabels = const [
    'Illustration',
    'Painting',
    'Drawing',
    'Sculpting',
    'Photography',
    'Graphic Design',
  ];

  List<String> selectedInterests = [];

  void _toggleInterest(String interest) {
    setState(() {
      if (selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      } else {
        if (selectedInterests.length < 6) {
          selectedInterests.add(interest);
        }
      }
    });
  }

  void _removeInterest(String interest) {
    setState(() {
      selectedInterests.remove(interest);
    });
  }

  Future<void> createUserProfile(String location, String company, String school, ) async {
    var url = 'https://new-fellow-project.vercel.app/gusers';

    final response = await http.post(
      Uri.parse(url),
      body: {

      }
    );
  }

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
                    'assets/icons/progress4.svg',
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
                          text: "Select Your",
                        ),
                        TextSpan(
                          text: " Interests!",
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
                    'Select up to 6 interests!',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 10), // Added for spacing
                const Text(
                  'Creative Labels', // Add your small text here
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10), // Added for spacing
                Wrap(
                  spacing: 8.0,
                  children: creativeLabels
                      .map((label) => FilterChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start, // Align children at the top

                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: SvgPicture.asset('assets/icons/AddInterest.svg',
                              height: 20, width: 20),
                        ),
                        Text(label,
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            )),
                      ],
                    ),
                    selected: selectedInterests.contains(label),
                    backgroundColor: selectedInterests.contains(label)
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    onSelected: (_) => _toggleInterest(label),
                  ))
                      .toList(),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OnboardingDone()),
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

class MyFilterChip extends StatefulWidget {
  @override
  _MyFilterChipState createState() => _MyFilterChipState();
}

class _MyFilterChipState extends State<MyFilterChip> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text('My Filter Chip'),
      selected: _isSelected,
      onSelected: (bool selected) {
        setState(() {
          _isSelected = selected;
        });
      },
      // You can customize the appearance of the chip here
      // by providing values to properties like labelStyle, backgroundColor, etc.
    );
  }
}