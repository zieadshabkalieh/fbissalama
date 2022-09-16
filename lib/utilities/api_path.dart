class ApiPath {
  static String journeys() => 'journeys/';
  static String user(String uid) => 'users/$uid';
  static String addToJourneys(String uid, String journey,String journeyId) => 'journeys/$uid/$journeyId/$journey';
  static String myJourneys(String uid) => 'users/$uid/cart/';
}