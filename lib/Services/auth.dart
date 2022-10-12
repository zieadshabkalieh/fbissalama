import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbissalama/Widgets/widgets/custom_snack_bar.dart';
import 'package:fbissalama/models/verifying.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

//TODO 1-dispose splash screen 2- when we get back from otp to main screen we should kill it
abstract class AuthBase {
  // Future<User?> signInWithEmailAndPassword(String email, String password);

  // Future<User?> signUpWithEmailAndPassword(String email, String password);

  // Future<void> signInwithPhoneNumber(String verificationId, String smsCode,
  //     BuildContext context);

  User? get currentUser;

  Stream<User?> authStateChanges();

  Future<void> addUser(String number, String pos);

  Future googleSignIn(BuildContext context);

  Future<void> verifyPhoneNumber(BuildContext context, String number);

  Future<void> logout(BuildContext context);
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final storage = const FlutterSecureStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  // @override
  // Future<User?> signInWithEmailAndPassword(String email, String password) async {
  //   final userAuth = await _firebaseAuth.signInWithEmailAndPassword(
  //       email: email, password: password);
  //   return userAuth.user;
  // }

  // @override
  // Future<User?> signUpWithEmailAndPassword(String email,
  //     String password) async {
  //   final userAuth = await _firebaseAuth.createUserWithEmailAndPassword(
  //       email: email, password: password);
  //   return userAuth.user;
  // }

  // @override
  // Future<void> signInwithPhoneNumber(
  //     String verificationId, String smsCode, BuildContext context)
  // async {
  //   try {
  //     AuthCredential credential = PhoneAuthProvider.credential(
  //         verificationId: verificationId, smsCode: smsCode);
  //     UserCredential userCredential =
  //     await _firebaseAuth.signInWithCredential(credential);
  //     storeTokenAndData(userCredential);

  // Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  //     showSnackBar(context, "logged In");
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  // }

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  Future<void> addUser(String number, String pos) async =>
      await _firestore.collection('users').add({
        'Position': pos,
        'Number': number,
      }).then((value) {
        // if (signedInUser!= null) { }
      });

  @override
  Future googleSignIn(BuildContext context, [bool mounted = true]) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      storeTokenAndData(userCredential);
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      showSnackBar(context, userCredential.user!.displayName.toString());
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  @override
  Future<void> verifyPhoneNumber(BuildContext context, String number) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      //TODO we should use this when verification complete
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseException e) {
        customSnackBar(
            context, e.message.toString(), 3, Colors.white24, Colors.brown, 17);
      },
      codeSent: (String vID, int? resendToken, [bool mounted = true]) async {
        Provider.of<Verifying>(context, listen: false).changevID(vID);
        String? code;
        try {
          code = await AltSmsAutofill().listenForSms;
        } catch (e) {
          showSnackBar(context, e.toString());
        }
        if (!mounted) return;
        Provider.of<Verifying>(context, listen: false).setCode(code.toString());
      },
      codeAutoRetrievalTimeout: (String vID) {
        showSnackBar(context, 'ِLogged In Successfully');
      },
      timeout: const Duration(seconds: 5),
    );
  }

  @override
  Future<void> logout(BuildContext context) async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      await storage.delete(key: "token");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void storeTokenAndData(UserCredential userCredential) async {
    await storage.write(
        key: "token", value: userCredential.credential!.token.toString());
    await storage.write(key: "credential", value: userCredential.toString());
  }

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  void showSnackBar(BuildContext context, String text) {
    customSnackBar(context, text, 3, Colors.white24, Colors.brown, 17);
  }
}
