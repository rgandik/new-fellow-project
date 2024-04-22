

import 'package:flutter/material.dart';
// import 'package:provider'

class Onboarding_Provider extends ChangeNotifier {
  TextEditingController locationController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  void updateLocation(String location) {
    locationController.text = location;
    //notifyListeners();
  }

  void updateCompany(String company) {
    companyController.text = company;
    //notifyListeners();
  }

  void updateSchool(String school) {
    schoolController.text = school;
    //notifyListeners();
  }
}