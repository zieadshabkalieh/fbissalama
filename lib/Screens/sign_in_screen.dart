import 'dart:ui';
import 'package:fbissalama/Screens/otp.dart';
import 'package:fbissalama/Services/auth.dart';
import 'package:fbissalama/Widgets/LoginWidgets/country_picker.dart';
import 'package:fbissalama/Widgets/LoginWidgets/text_fields.dart';
import 'package:fbissalama/Widgets/widgets/drop_down.dart';
import 'package:fbissalama/Widgets/widgets/custom_snack_bar.dart';
import 'package:fbissalama/Widgets/widgets/main_buttom.dart';
import 'package:fbissalama/models/provider_controller.dart';
import 'package:fbissalama/utilities/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController number = TextEditingController();
    // final TextEditingController password = TextEditingController();
    String pos = 'Agency';
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Stack(children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      AppAssets.backgroundLogin,
                    ),
                  ),
                ),
                height: size.height,
              ),
              Container(
                height: size.height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Colors.black38,
                        Colors.black.withOpacity(0.5),
                        Colors.black38,
                      ],
                    )),
              ),
            ]),
            Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 1, sigmaX: 1),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    // child:
                    Text(
                      'LOGIN',
                      style: GoogleFonts.davidLibre(
                        textStyle: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(.8),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.person_pin_circle_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Consumer<ProviderController>(
                            builder: (context, value, child) {
                          return DropDown(value, 'Agency', Colors.grey.shade500,
                              Colors.grey.shade500, Colors.grey.shade200, 15.0,
                              items: const ['Agency', 'Clerk', 'Passenger'],
                              callbackDropDown: (newValue) {
                            pos = newValue;
                          });
                        }),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    myTextField(
                        size.width / 4.5,
                        size.width / 1.10,
                        number,
                        false,
                        const CountryPicker(),
                        'Phone Number...',
                        TextInputType.number),
                    // MyTextField(
                    //     size,
                    //     password,
                    //     true,
                    //     // Icon(Icons.lock_outline,
                    //     //         color: Colors.white),
                    //     SizedBox(
                    //       width: 113,
                    //       child: Icon(
                    //         Icons.lock_outline,
                    //         color: Colors.white.withOpacity(.8),
                    //       ),
                    //     ),
                    //     'Password...',
                    //     TextInputType.text),
                    const SizedBox(
                      height: 50,
                    ),
                    MainButton(
                        const [Colors.white10, Colors.white54, Colors.white10],
                        "",
                        text: Text(
                          "Login",
                          style: GoogleFonts.adamina(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ), onTap: () async {
                      if (number.text.isNotEmpty) {
                        try {
                          //when we need to add the user to firestore
                          Auth().addUser(number.text, pos);
                          if (number.text[0] == "0" && number.text[1] == "9") {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => OTP(
                                        number: Provider.of<ProviderController>(
                                                    context,
                                                    listen: false)
                                                .dialCodeDigits +
                                            number.text.substring(1),
                                      )),
                            );
                          } else {
                            HapticFeedback.lightImpact();
                            Fluttertoast.showToast(
                              msg: 'Invalid Phone Number',
                            );
                          }
                        } catch (e) {
                          customSnackBar(context, e.toString(), 3,
                              Colors.white24, Colors.brown, 17);
                        }
                      } else {
                        HapticFeedback.lightImpact();
                        Fluttertoast.showToast(
                          msg: 'Please Fill All Gaps',
                        );
                      }
                    }),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "OR",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    MainButton(
                      const [Colors.white10, Colors.white54, Colors.white10],
                      AppAssets.googleicon,
                      text: const Text(
                        "Continue with Google",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                      onTap: () async {
                        await Auth().googleSignIn(context);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Book your Journeys Online",
                      style: GoogleFonts.lobster(
                          textStyle: const TextStyle(
                              fontSize: 25, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
