

import 'package:flutter/material.dart';
// import 'package:provider'

class Onboarding_Provider extends ChangeNotifier {
  TextEditingController locationController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController schoolController = TextEditingController();

  void updateLocation(String location) {
    locationController.text = location;
    notifyListeners();
  }

}