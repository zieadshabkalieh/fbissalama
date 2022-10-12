// import 'package:alt_sms_autofill/alt_sms_autofill.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fbissalama/Screens/main_home_screen.dart';
// import 'package:fbissalama/Widgets/widgets/custom_snack_bar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// abstract class AuthBase {
//   User? get currentUser;
//
//   Stream<User?> authStateChanges();
//
//   Future<User?> signInWithEmailAndPassword(String email, String password);
//
//   Future<User?> signUpWithEmailAndPassword(String email, String password);
//
//   Future<void> addUser(String number, String pos);
//
//   Future<void> signInwithPhoneNumber(String verificationId, String smsCode,
//       BuildContext context);
//
//   Future googleSignIn(BuildContext context);
//
//   Future<void> verifyPhoneNumber(
//       String phoneNumber, BuildContext context, Function setData);
//
//   Future<void> initSmsListener(BuildContext context);
//
//   Future<void> logout(BuildContext context);
// }
//
// class Auth implements AuthBase {
//   final _firebaseAuth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;
//   final storage = const FlutterSecureStorage();
//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: [
//       'email',
//       'https://www.googleapis.com/auth/contacts.readonly',
//     ],
//   );
//
//   @override
//   Future<User?> signInWithEmailAndPassword(String email, String password) async {
//     final userAuth = await _firebaseAuth.signInWithEmailAndPassword(
//         email: email, password: password);
//     return userAuth.user;
//   }
//
//   @override
//   Future<User?> signUpWithEmailAndPassword(String email,
//       String password) async {
//     final userAuth = await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email, password: password);
//     return userAuth.user;
//   }
//
//   @override
//   Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();
//
//   @override
//   User? get currentUser => _firebaseAuth.currentUser;
//
//   @override
//   Future<void> logout(BuildContext context) async {
//     try {
//       await _googleSignIn.signOut();
//       await _firebaseAuth.signOut();
//       await storage.delete(key: "token");
//     } catch (e) {
//       showSnackBar(context, 'ِLogged In Successfully');
//     }
//   }
//
//   @override
//   Future<void> addUser(String number, String pos) async =>
//       await _firestore.collection('users').add({
//         'Position': pos,
//         'Number': number,
//       }).then((value) {
//         // if (signedInUser!= null) {
//       });
//
//   @override
//   Future<String?> initSmsListener(BuildContext context) async {
//     try {
//       return await AltSmsAutofill().listenForSms;
//     } catch (e) {
//       showSnackBar(context, e.toString());
//       return e.toString();
//     }
//   }
//
//   @override
//   Future<void> signInwithPhoneNumber(
//       String verificationId, String smsCode, BuildContext context, [bool mounted = true])
//   async {
//     try {
//       AuthCredential credential = PhoneAuthProvider.credential(
//           verificationId: verificationId, smsCode: smsCode);
//       UserCredential userCredential =
//       await _firebaseAuth.signInWithCredential(credential);
//       storeTokenAndData(userCredential);
//       if (!mounted) return;
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (builder) => const MainHome()),
//               (route) => false);
//       showSnackBar(context, "logged In");
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }
//   @override
//   Future googleSignIn(BuildContext context, [bool mounted = true]) async {
//     try {
//       GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
//       GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount!.authentication;
//       AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );
//       UserCredential userCredential =
//       await _firebaseAuth.signInWithCredential(credential);
//       storeTokenAndData(userCredential);
//       if (!mounted) return;
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (builder) => const MainHome()),
//               (route) => false);
//
//       final snackBar =
//       SnackBar(content: Text(userCredential.user!.displayName.toString()));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     } catch (e) {
//       final snackBar = SnackBar(content: Text(e.toString()));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//   }
//
//   @override
//   Future<void> verifyPhoneNumber(
//       String phoneNumber, BuildContext context, Function setData) async {
//     verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
//       showSnackBar(context, "Verification Completed");
//     }
//     verificationFailed(FirebaseAuthException exception) {
//       showSnackBar(context, exception.toString());
//     }
//     codeSent(String verificationID, [int? forceResnedingtoken]) {
//       showSnackBar(context, "Verification Code sent on the phone number");
//       setData(verificationID);
//     }
//
//     codeAutoRetrievalTimeout(String verificationID) {
//       showSnackBar(context, "Time out");
//     }
//     try {
//       await _firebaseAuth.verifyPhoneNumber(
//           timeout: const Duration(seconds: 60),
//           phoneNumber: phoneNumber,
//           verificationCompleted: verificationCompleted,
//           verificationFailed: verificationFailed,
//           codeSent: codeSent,
//           codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }
//
//   //try to remove this make the same of user method
//   void storeTokenAndData(UserCredential userCredential) async {
//     await storage.write(
//         key: "token", value: userCredential.credential!.token.toString());
//     await storage.write(
//         key: "usercredential", value: userCredential.toString());
//   }
//
//   Future<String?> getToken() async {
//     return await storage.read(key: "token");
//   }
//
//   void showSnackBar(BuildContext context, String text) {
//     customSnackBar(context, text, 3, Colors.white24, Colors.brown, 17);
//   }
// }
