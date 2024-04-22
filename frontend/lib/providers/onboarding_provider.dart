import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:provider'

class Onboarding_Provider extends ChangeNotifier {
  TextEditingController locationController = TextEditingController();
  double? latitude;
  double? longitude;
  TextEditingController companyController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  DateTime? birthday;
  List<String> selectedInterests = [];
  bool finishedOnboarding = false;


  void updateLocation(String location) {
    locationController.text = location;
    notifyListeners();
  }

  void getLocation() async {
    List<Location> tempLocation = (await locationFromAddress(locationController.text));
    /*if (tempLocation[0].latitude.isNaN) {
      return false;
    } else {
      return true;
    }*/
    latitude = double.parse(tempLocation[0].latitude.toString());
    longitude = double.parse(tempLocation[0].longitude.toString());
    print(latitude);
    print(longitude);
    }

  double? locationLat() {
    return latitude;
  }

  double? locationLon() {
    return longitude;
  }

  void updateCompany(String company) {
    companyController.text = company;
    notifyListeners();
  }

  String? company() {
    return companyController.text;
  }

  void updateSchool(String school) {
    schoolController.text = school;
    notifyListeners();
  }

  String? school() {
    return schoolController.text;
  }

  void updateName(String name) {
    nameController.text = name;
    notifyListeners();
  }

  String? name() {
    return nameController.text;
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

  int? day() {
    return birthday!.day;
  }

  int? month() {
    return birthday!.month;
  }

  int? year() {
    return birthday!.year;
  }

  void updateSelectedInterests(List<String> interests) {
    selectedInterests = interests;
    notifyListeners();
  }

  List<String> interests() {
    return selectedInterests;
  }

  void finishOnboarding() {
    // Add code to finish onboarding
    finishedOnboarding = true;
    notifyListeners();
  }


}