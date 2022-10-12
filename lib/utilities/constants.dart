import 'package:firebase_database/firebase_database.dart';

String documentIdFromLocalData() => DateTime.now().toIso8601String();

class Consts {
  static DatabaseReference journeyRef = FirebaseDatabase.instance.ref();
  static const String pathJourneys = 'journeys';
  static const String pathSourceCity = 'sourceCity';
  static const String pathDestinationCity = 'destinationCity';
  static const String pathTimeJourney = 'time';
  static const String pathDateJourney = 'Date';
  static const String pathPriceJourney = 'Price';
}
