

import 'package:flutter/material.dart';
// import 'package:provider'

class Onboarding_Provider extends ChangeNotifier {
  TextEditingController locationController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  DateTime? birthday;


  void updateLocation(String location) {
    locationController.text = location;
    notifyListeners();
  }

  void updateCompany(String company) {
    companyController.text = company;
    notifyListeners();
  }

  void updateSchool(String school) {
    schoolController.text = school;
    notifyListeners();
  }

  void updateBirthday(String? selectedMonth, String? selectedDay, String? selectedYear) {
    if (selectedMonth != null && selectedDay != null && selectedYear != null) {
      final int month = int.parse(selectedMonth);
      final int day = int.parse(selectedDay);
      final int year = int.parse(selectedYear);
      birthday = DateTime(year, month, day);
      // print()
      notifyListeners();
    }
  }

}