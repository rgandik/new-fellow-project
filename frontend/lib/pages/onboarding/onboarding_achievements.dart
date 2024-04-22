import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/providers/onboarding_provider.dart';
import 'package:provider/provider.dart';
import 'package:frontend/widgets/myEntryField.dart';
import 'package:frontend/pages/onboarding/onboarding_birthday.dart';
import 'package:frontend/widgets/userInputField.dart';

class OnboardingAchievements extends StatefulWidget {
  OnboardingAchievements({Key? key}) : super(key: key);

  @override
  _OnboardingAchievementsState createState() => _OnboardingAchievementsState();
}

class _OnboardingAchievementsState extends State<OnboardingAchievements> {
  TextEditingController companyController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  bool companyError = false;
  bool schoolError = false;

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
                            userInputField(
                              controller: companyController,
                              error: companyError,
                              errorMessage: 'Please enter company name',
                              hintText: 'Citadel',
                            ), // Assuming this is your custom text input widget
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
                            userInputField(
                              controller: schoolController,
                              error: schoolError,
                              errorMessage: 'Please enter school name',
                            ), // Assuming this is your custom text input widget
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Add the buttons row here
                // const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle left button press
                          print('Left button pressed');
                          Navigator.of(context).pop();
                          // print the value in onboarding provider
                          // Consumer<Onboarding_Provider>(
                          //   builder: (context, provider, child) {
                          //     print("Location: ");
                          //     // print(provider.locationController.text);
                          //     return Container();
                          //     // return Container();
                          //   },
                          // );
                          final provider = Provider.of<Onboarding_Provider>(context, listen: false);
                          print("Location: ");
                          print(provider.locationController.text);
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
                          if (companyController.text.isEmpty) {
                            setState(() {
                              companyError = true;
                            });
                          } else {
                            setState(() {
                              companyError = false;
                            });
                          }
                          if (schoolController.text.isEmpty) {
                            setState(() {
                              schoolError = true;
                            });
                          } else {
                            setState(() {
                              schoolError = false;
                            });
                          }
                          if (!companyError && !schoolError) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const OnboardingBirthday()),
                            );
                            context.read<Onboarding_Provider>().updateCompany(companyController.text);
                            context.read<Onboarding_Provider>().updateSchool(schoolController.text);
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
}
