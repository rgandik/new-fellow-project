import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/providers/onboarding_provider.dart';
import 'package:frontend/widgets/userInputField.dart'; // Assuming you've moved your custom text input widget to 'widgets' folder
import 'package:frontend/pages/onboarding/onboarding_achievements.dart';
import 'package:provider/provider.dart';

class OnboardingLocation extends StatefulWidget {
  OnboardingLocation({Key? key}) : super(key: key);

  @override
  _OnboardingLocationState createState() => _OnboardingLocationState();
}

class _OnboardingLocationState extends State<OnboardingLocation> {
  TextEditingController locationController = TextEditingController();
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            minWidth: MediaQuery.of(context).size.width,
          ),
          child: IntrinsicHeight(
            child: Column(
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
                                style: TextStyle(color: Constants.myOrange),
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
                        child: userInputField(
                          controller: locationController,
                          error: showError,
                          errorMessage: showError ? 'Location is required' : null,
                          hintText: 'Austin, TX',
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Adjust the spacing between the text field and the image
                      SvgPicture.asset(
                        'assets/icons/mapimage.svg',
                        // Replace 'WhereAreYouLocatedImage.svg' with your SVG image path
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
                      // GestureDetector(
                      //   onTap: () {
                      //     // Handle left button press
                      //     print('Left button pressed');
                      //     Navigator.of(context).pop();
                      //   },
                      //   child: SvgPicture.asset(
                      //     'assets/icons/Back Arrow.svg',
                      //     height: 65, // Adjust the height as needed
                      //   ),
                      // ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          // Handle right button press
                          if (locationController.text.isNotEmpty) {
                            setState(() {
                              showError = false;
                            });
                            print('Right button pressed');
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => OnboardingAchievements()),
                            );
                            context.read<Onboarding_Provider>().updateLocation(locationController.text);
                          } else {
                            setState(() {
                              showError = true;
                            });
                          }
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
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Add listener to the text field to update error state
    locationController.addListener(updateErrorState);
  }

  @override
  void dispose() {
    // Remove listener when disposing the widget
    locationController.removeListener(updateErrorState);
    super.dispose();
  }

  // Method to update error state based on text field value
  void updateErrorState() {
    setState(() {
      showError = !showError ? false : locationController.text.isEmpty;
    });
  }
}
