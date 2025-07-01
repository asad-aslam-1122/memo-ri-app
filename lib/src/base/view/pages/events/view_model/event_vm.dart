import 'package:flutter/material.dart';

import '../model/event_model.dart';

class EventVm extends ChangeNotifier {
  List<EventModel> eventModelList = [];

  void update() {
    notifyListeners();
  }
}
