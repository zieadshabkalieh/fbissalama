// import 'package:fbissalama/Services/auth.dart';
// import 'package:fbissalama/models/user_data.dart';
// import 'package:fbissalama/utilities/constants.dart';
// import 'package:fbissalama/utilities/enum.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'database_controller.dart';
//
// class AuthController with ChangeNotifier {
//   final AuthBase auth;
//   String phone;
//   AuthFormType authFormType;
//   // final database = FirestoreDatabase('123');
//
//   AuthController({
//     required this.auth,
//     this.phone ='',
//     this.authFormType = AuthFormType.login,
//   });
//
//   Future<void> submit(String phoneNumber,User user) async {
//     try {
//         await database.setUserData(UserData(
//           uid: user.uid ?? documentIdFromLocalData(),
//           phone: phoneNumber,
//         ));
//         notifyListeners();
//     } catch (e) {
//       print("Exception  method submit SignUp WithPhoneNumber $e");
//       rethrow;
//     }
//   }
//
//
//   Future<void> logout() async {
//     try {
//       await auth.logout();
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
