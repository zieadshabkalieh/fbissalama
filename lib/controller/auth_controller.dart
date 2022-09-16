import 'package:fbissalama/Services/auth.dart';
import 'package:fbissalama/utilities/enum.dart';
import 'package:flutter/material.dart';


class AuthController with ChangeNotifier {
  late final AuthBase auth;
  late AuthFormType authFormType;
  // TODO: It's not a best practice thing but it's temporary



  Future<void> logout() async {
    try {
      await auth.logout();
    } catch (e) {
      rethrow;
    }
  }
}
