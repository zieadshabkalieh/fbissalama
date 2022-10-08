import 'package:flutter/material.dart';
class Favorite extends ChangeNotifier {
  final Text date;
  final Text time;
  final Text source;
  final Text destination;
  final Text price;

  Favorite(this.date, this.time, this.source, this.destination, this.price);
}