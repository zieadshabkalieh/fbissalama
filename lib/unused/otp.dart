// final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
// final TextEditingController _pinOTPCodeController = TextEditingController();
// final FocusNode _pinOTPCodeFoucus = FocusNode();
// PinPut(
//   fieldsCount: 6,
//   textStyle: const TextStyle(
//       fontSize: 25.0, color: Colors.white),
//   eachFieldWidth: 45.0,
//   eachFieldHeight: 50.0,
//   focusNode: _pinOTPCodeFoucus,
//   controller: _pinOTPCodeController,
//   submittedFieldDecoration: pinOTPCodeDecoration,
//   selectedFieldDecoration: pinOTPCodeDecoration,
//   followingFieldDecoration: pinOTPCodeDecoration,
//   onSubmit: (pin) async {
//     try {
//       // await FirebaseAuth.instance
//       //     .signInWithCredential(
//       //         PhoneAuthProvider.credential(
//       //             verificationId: varificationCode!,
//       //             smsCode: pin))
//       //     .then((value) {
//       //   // print(
//       //   //     "The pin Data is: ${value.credential!.token}");
//       //   // Auth().storeTokenAndData(value);
//       //   if (value.user != null) {
//       //     Navigator.of(context).push(MaterialPageRoute(
//       //         builder: (context) => MainHome()));
//       //   }
//       // });
//       await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(verificationId: varificationCode!,smsCode: pin)).then((value) {
//             // print("The pin Data is: ${value.credential!.token}");
//         // Auth().storeTokenAndData(value);
//         if (value.user != null) {
//           // Auth().verifyPhoneNumber(widget.number, context, setData);
//           Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => const MainHome()));
//         }
//       });
//     } catch (e) {
//       FocusScope.of(context).unfocus();

// customSnackBar(context, 'Invalid OTP', 60, Colors.white24, Colors.brown, 17);
//       );
//     }
//     // try {
//     //   await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(verificationId: varificationCode!, smsCode: pin)).then((value) {
//     //     if (value.user != null) {
//     //       Navigator.of(context).push(MaterialPageRoute(
//     //           builder: (context) => MainHome()));
//     //     }
//     //   });
//     // } catch (e) {
//     //   FocusScope.of(context).unfocus();

// customSnackBar(context, 'Invalid OTP', 3, Colors.white24, Colors.brown, 17);
//     // }
//   },
// ),
// ),