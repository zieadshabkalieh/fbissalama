import 'package:flutter/material.dart';

class Favorite {
  final Text date;
  final Text time;
  final Text source;
  final Text destination;
  final Text price;

  Favorite(this.date, this.time, this.source, this.destination, this.price);

  @override
  bool operator ==(Object other) {
    return other is Favorite &&
        date.toString() == other.date.toString() &&
        time.toString() == other.time.toString() &&
        source.toString() == other.source.toString() &&
        destination.toString() == other.destination.toString() &&
        price.toString() == other.price.toString();
  }

  @override
  int get hashCode => 0;
}
