import 'dart:async';
import 'package:fbissalama/Screens/LoginScreen/LoginScreen.dart';
import 'package:fbissalama/Services/auth.dart';
import 'package:fbissalama/utilities/assets.dart';
import 'package:fbissalama/utilities/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashTimer extends StatefulWidget {
  const SplashTimer({Key? key}) : super(key: key);

  @override
  State<SplashTimer> createState() => _SplashTimerState();
}


class _SplashTimerState extends State<SplashTimer> {
  @override
  void dispose() {
    super.dispose();
  }
  // bool _isVisible = false;

  _SplashTimerState() {
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        AuthFormType.login;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
        //   dispose();
      });
    });
    Timer(const Duration(milliseconds: 10), () {
      setState(() {
        // _isVisible = true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor
            ],
            begin: const FractionalOffset(0, 0),
            end: const FractionalOffset(1.0, 0.0),
            stops: const [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(milliseconds: 1200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  AppAssets.busIcon,
                  fit: BoxFit.fitHeight,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Bissalama",
                style: GoogleFonts.lobster(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SpinKitPouringHourGlassRefined(
                  color: Colors.white, size: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
