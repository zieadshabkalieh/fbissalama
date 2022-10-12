import 'package:fbissalama/Screens/add_journey.dart';
import 'package:flutter/material.dart';

class ProviderController extends ChangeNotifier {
  String dialCodeDigits = '+963';
  DateTime date = DateTime.now();
  TimeOfDay time = const TimeOfDay(
    hour: 9,
    minute: 00,
  );
  bool dateChanged = false;
  bool timeChanged = false;

  update(String hint, CallbackDropDown callback) {
    callback(hint);
    notifyListeners();
  }

  setDate(date) {
    this.date = date;
    notifyListeners();
  }

  setTime(time) {
    this.time = time;
    notifyListeners();
  }
}
