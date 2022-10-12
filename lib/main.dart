import 'package:fbissalama/Screens/about_page.dart';
import 'package:fbissalama/Screens/favorite_journey.dart';
import 'package:fbissalama/Screens/settings.dart';
import 'package:fbissalama/Screens/add_journey.dart';
import 'package:fbissalama/Screens/current_journey.dart';
import 'package:fbissalama/Screens/main_home_screen.dart';
import 'package:fbissalama/Screens/sign_in_screen.dart';
import 'package:fbissalama/Screens/splashscreen.dart';
import 'package:fbissalama/models/provider_controller.dart';
import 'package:fbissalama/models/following.dart';
import 'package:fbissalama/models/verifying.dart';
import 'package:fbissalama/utilities/router.dart';
import 'package:fbissalama/utilities/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Following>(
          create: (BuildContext context) => Following(),
        ),
        ChangeNotifierProvider<ProviderController>(
          create: (BuildContext context) => ProviderController(),
        ),
        ChangeNotifierProvider<Verifying>(
          create: (BuildContext context) => Verifying(),
        ),
        //TODO
        //Add AuthController Here...
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Bissalama",
        onGenerateRoute: onGenerate,
        initialRoute: AppRoutes.splashScreenPage,
        routes: {
          AppRoutes.loginPage: (context) => const SignInScreen(),
          AppRoutes.splashScreenPage: (context) => const SplashScreen(),
          AppRoutes.mainHomePage: (context) => const MainHome(),
          AppRoutes.addJourneyPage: (context) => const AddJourneyPage(),
          AppRoutes.currentJourneyPage: (context) => const CurrentJourneyPage(),
          AppRoutes.favoriteJourneyPage: (context) => const FavoritePage(),
          AppRoutes.settingsPage: (context) => const SettingsPage(),
          AppRoutes.aboutPage: (context) => const AboutPage(),
        },
      ),
    ),
  );
}
