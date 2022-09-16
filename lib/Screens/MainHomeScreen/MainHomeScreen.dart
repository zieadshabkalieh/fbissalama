import 'package:fbissalama/Screens/LoginScreen/LoginScreen.dart';
import 'package:fbissalama/controller/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainHome extends StatelessWidget {
  const MainHome({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final _firebaseAuth = FirebaseAuth.instance;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome",
              style: GoogleFonts.arya(
                textStyle: TextStyle(fontSize: 60, color: Colors.red),
              ),
            ),
            const Icon(
              Icons.card_giftcard,
              size: 60,
              color: Colors.red,
            ),
            ElevatedButton(
              child: const Text('Log Out'),
              onPressed: () {
                try {
                  _firebaseAuth.signOut();
                  Navigator.pop(context);
                } catch (e) {
                    
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
