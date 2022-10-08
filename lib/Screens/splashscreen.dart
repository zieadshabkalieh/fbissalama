import 'package:fbissalama/Services/auth.dart';
import 'package:fbissalama/utilities/assets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), ([bool mounted = true]) async {
      final String? user = FirebaseAuth.instance.currentUser?.phoneNumber;
      String? token = await Auth().getToken();
      if (token != null || user != null) {
        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed('/');
      }
    });
    return Scaffold(
      body: Container(
        color: Colors.blueAccent,
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
    );
  }
}
