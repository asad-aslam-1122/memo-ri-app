import 'package:flutter/material.dart';

class SubscriptionVm extends ChangeNotifier {
  bool hasFreeTrial = true;
  bool hasSubscribed = false;

  void update() {
    notifyListeners();
  }
}
