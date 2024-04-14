import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/pages/CityCircleFrontPage.dart';
import 'package:frontend/widgets/myEntryField.dart';

class WhenBirthday extends StatelessWidget {
  const WhenBirthday({Key? key});

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
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildDropdownField(
                                    hint: 'MM',
                                    items: _buildMonthItems(),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _buildDropdownField(
                                    hint: 'DD',
                                    items: _buildDayItems(),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _buildDropdownField(
                                    hint: 'YYYY',
                                    items: _buildYearItems(),
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
                      MaterialPageRoute(builder: (context) => CityCircleFrontPage()),
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

  Widget _buildDropdownField({required String hint, required List<DropdownMenuItem<String>> items}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2.0, // Adjust the width as needed
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            hint: Text(
              hint,
              style: TextStyle(fontWeight: FontWeight.bold), // Add this line to bold the hint
            ),
            items: items,
            onChanged: (value) {
              print(value);
            },
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildMonthItems() {
    return List.generate(
      12,
          (index) => DropdownMenuItem<String>(
        value: (index + 1).toString().padLeft(2, '0'),
        child: Text((index + 1).toString().padLeft(2, '0')),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildDayItems() {
    return List.generate(
      31,
          (index) => DropdownMenuItem<String>(
        value: (index + 1).toString().padLeft(2, '0'),
        child: Text((index + 1).toString().padLeft(2, '0')),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildYearItems() {
    // Assuming a range of 100 years from current year
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
