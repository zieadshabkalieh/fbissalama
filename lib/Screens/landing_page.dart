// import 'package:fbissalama/Screens/SignInScreen/sign_in_screen.dart';
// import 'package:fbissalama/Services/auth.dart';
// import 'package:fbissalama/controller/auth_controller.dart';
// import 'package:fbissalama/controller/database_controller.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'buttom_navbar.dart';
//
//
// class LandingPage extends StatelessWidget {
//   const LandingPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<AuthBase>(context);
//     return StreamBuilder<User?>(
//       stream: auth.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           final user = snapshot.data;
//           if (user == null) {
//             return ChangeNotifierProvider<AuthController>(
//               create: (_) => AuthController(auth: auth),
//               child:  SignInScreen(),
//             );
//           }
//           return ChangeNotifierProvider<AuthController>(
//             create: (_) => AuthController(auth: auth),
//             child: Provider<Database>(
//                 create: (_) => FirestoreDatabase(user.uid),
//                 child: const BottomNavbar()),
//           );
//         }
//         // TODO: We will refactor this to make one component for loading
//         return const Scaffold(
//           body: Center(
//             child: CircularProgressIndicator(),
//           ),
//         );
//       },
//     );
//   }
// }
