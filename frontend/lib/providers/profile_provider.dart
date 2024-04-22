import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {

  bool _onboarded = false;

  bool onboarded() {
    return _onboarded;
  }

  Future<void> isOnboarded() async {
    _onboarded = true;
    print('Activated');
    notifyListeners();
  }

  Future<void> notOnboarded() async {
    _onboarded = false;
    notifyListeners();
  }

}