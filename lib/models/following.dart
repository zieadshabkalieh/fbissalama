import 'package:fbissalama/models/favorite.dart';
import 'package:flutter/material.dart';
class Following extends ChangeNotifier{
  List<Favorite> list = [];
  add(favorite){
    list.add(favorite);
    notifyListeners();
  }
  remove(favorite){
    list.remove(favorite);
    notifyListeners();
  }
}