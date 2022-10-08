import 'package:fbissalama/Services/auth.dart';
import 'package:fbissalama/Widgets/NavigationDrawer/navigation_drawer.dart';
import 'package:fbissalama/Widgets/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainHome extends StatelessWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome",
              style: GoogleFonts.arya(
                textStyle: const TextStyle(fontSize: 60, color: Colors.red),
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
                  Auth().logout(context);
                  Navigator.of(context).pushReplacementNamed('/');
                } catch (e) {
                  customSnackBar(context, e.toString(), 3, Colors.white24, Colors.brown, 17);
                }
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Home'),
      ),
      drawer: const NavigationDrawer(),
    );
  }
}
