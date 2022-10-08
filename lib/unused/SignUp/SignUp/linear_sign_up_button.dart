import 'package:fbissalama/Screens/main_home_screen.dart';
import 'package:fbissalama/Services/auth.dart';
import 'package:fbissalama/Widgets/widgets/drop_down.dart';
import 'package:fbissalama/Widgets/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class LinearSignUpButton extends StatefulWidget {
  final TextEditingController email;
  final TextEditingController password;
  const LinearSignUpButton({Key? key, required this.email, required this.password}) : super(key: key);

  @override
  State<LinearSignUpButton> createState() => LinearSignUpButtonState();
}

class LinearSignUpButtonState extends State<LinearSignUpButton> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;

  bool circular = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        setState(() {
          circular = true;
        });
        if (widget.email.text.isNotEmpty && widget.password.text.isNotEmpty) {
          try {
            setState(() {
              circular = false;
            });
            //when we will enable it when we need to enable signUp
            // Auth().signUpWithEmailAndPassword(
            //     widget.email.text, widget.password.text);
            Auth().addUser(widget.email.text, DropdownState().hint);
            //to enable phone authentication
            // if ("${widget.number.text[0]}" == "0") {
            // number.text = number.text.substring(1);
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => const MainHome()
                  //     OTP(
                  //   number:
                  //   CountryPickerState().dialCodeDigits +
                  //       widget.email.text.substring(1),
                  // ),
              ),
            );
            setState(() {
              circular = false;
            });
            // } else {
            //   HapticFeedback.lightImpact();
            //   Fluttertoast.showToast(
            //     msg: 'Invalid Phone Number',
            //   );
            //   setState(() {
            //     circular = false;
            //   });
            // }
          } catch (e) {
            customSnackBar(context, e.toString(), 3, Colors.white24, Colors.brown, 17);
            setState(() {
              circular = false;
            });}
        } else {
          HapticFeedback.lightImpact();
          Fluttertoast.showToast(
            msg: 'Please Fill All Gaps',
          );
          setState(() {
            circular = false;
          });
        }
      },
      child: Container(
        width: 150,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              colors: [Colors.white10, Colors.white54, Colors.white10]),
        ),
        child: Center(
          child: circular
              ? const CircularProgressIndicator()
              : Text(
            "Sign Up",
            style: GoogleFonts.adamina(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
