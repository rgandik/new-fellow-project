import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/pages/onboarding/onboarding_interests.dart';
import 'package:frontend/providers/onboarding_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/userInputField.dart';

class OnboardingBirthday extends StatefulWidget {
  const OnboardingBirthday({Key? key}) : super(key: key);

  @override
  _OnboardingBirthdayState createState() => _OnboardingBirthdayState();
}

class _OnboardingBirthdayState extends State<OnboardingBirthday> {
  TextEditingController nameController = TextEditingController();
  String? selectedMonth;
  String? selectedDay;
  String? selectedYear;
  bool nameError = false;
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: SvgPicture.asset(
                            'assets/icons/progress3.svg',
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
                                  text: "When is your",
                                ),
                                TextSpan(
                                  text: " Birthday?",
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
                            'Find some friends who are close to your age!',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Name',
                                        style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    userInputField(
                                      controller: nameController,
                                      error: nameError,
                                      errorMessage: 'Please enter your name',
                                      hintText: 'Tyler',
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _buildDropdownField(
                                            hint: selectedMonth ?? 'MM',
                                            items: _buildMonthItems(),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedMonth = value;
                                              });
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: _buildDropdownField(
                                            hint: selectedDay ?? 'DD',
                                            items: _buildDayItems(),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedDay = value;
                                              });
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: _buildDropdownField(
                                            hint: selectedYear ?? 'YYYY',
                                            items: _buildYearItems(),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedYear = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Added SizedBox
                        if (showError)
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              children: [
                                Icon(Icons.error_outline, color: Colors.red),
                                SizedBox(width: 10),
                                Text(
                                  'Please select all fields',
                                  style: TextStyle(color: Colors.red, fontSize: 16),

                                ),
                              ],
                            ),
                          ),
                        SizedBox(height: showError ? 16 : 40),
                        // Adjusted SizedBox height
                        SvgPicture.asset(
                          'assets/icons/birthdayCake.svg',
                          height: 300,
                          width: 400,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
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
                            height: 65,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            // Handle right button press
                            print('Right button pressed');
                            if (selectedMonth != null &&
                                selectedDay != null &&
                                selectedYear != null) {
                              // Hide the error message if all fields are selected
                              setState(() {
                                showError = false;
                              });
                              // Navigate to the next screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OnboardingInterests()),
                              );
                              // Update the context
                              context.read<Onboarding_Provider>().updateBirthday(
                                  selectedMonth, selectedDay, selectedYear);
                            } else {
                              // Show an error message if not all fields are selected
                              setState(() {
                                showError = true;
                              });
                            }
                          },
                          child: SvgPicture.asset(
                            'assets/icons/Front Arrow.svg',
                            height: 65,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
        )
      )
    );
  }

  Widget _buildDropdownField(
      {required String hint,
      required List<DropdownMenuItem<String>> items,
      required ValueChanged<String?> onChanged}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: null,
            hint: Text(
              hint,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            items: items,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildMonthItems() {
    if (selectedMonth != null &&
        selectedDay != null &&
        selectedYear != null) {
      // Hide the error message if all fields are selected
      setState(() {
        showError = false;
      });
    }
    return List.generate(
      12,
      (index) => DropdownMenuItem<String>(
        value: (index + 1).toString().padLeft(2, '0'),
        child: Text((index + 1).toString().padLeft(2, '0')),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildDayItems() {
    if (selectedMonth != null &&
        selectedDay != null &&
        selectedYear != null) {
      // Hide the error message if all fields are selected
      setState(() {
        showError = false;
      });
    }
    return List.generate(
      31,
      (index) => DropdownMenuItem<String>(
        value: (index + 1).toString().padLeft(2, '0'),
        child: Text((index + 1).toString().padLeft(2, '0')),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildYearItems() {
    if (selectedMonth != null &&
        selectedDay != null &&
        selectedYear != null) {
      // Hide the error message if all fields are selected
      setState(() {
        showError = false;
      });
    }
    final currentYear = DateTime.now().year;
    return List.generate(
      100,
      (index) => DropdownMenuItem<String>(
        value: (currentYear - index).toString(),
        child: Text((currentYear - index).toString()),
      ),
    );
  }
}
