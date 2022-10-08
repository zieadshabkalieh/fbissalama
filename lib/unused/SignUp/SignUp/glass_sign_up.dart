import 'dart:ui';
import 'package:fbissalama/Screens/sign_in_screen.dart';
import 'package:fbissalama/Services/auth.dart';
import 'package:fbissalama/Widgets/drop_down.dart';
import 'package:fbissalama/Widgets/LoginWidgets/text_fields.dart';
import 'package:fbissalama/unused/SignUp/SignUp/linear_sign_up_button.dart';
import 'package:fbissalama/utilities/assets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class GlassSignUp extends StatefulWidget {
  const GlassSignUp({Key? key}) : super(key: key);

  @override
  State<GlassSignUp> createState() => _GlassSignUpState();
}

class _GlassSignUpState extends State<GlassSignUp> {
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 1, sigmaX: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.width / 30,
                  bottom: size.width / 30,
                ),
                child: Text(
                  'SIGN UP',
                  style: GoogleFonts.davidLibre(
                    textStyle: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(.8),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  await Auth().googleSignIn(context);
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 60,
                  height: 60,
                  child: Card(
                    color: Colors.black,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.googleicon,
                          height: 25,
                          width: 25,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          "Continue with Google",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (builder) => PhoneAuthPage()));
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 60,
                  height: 60,
                  child: Card(
                    color: Colors.black,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.phoneicon,
                          height: 25,
                          width: 25,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          "Continue with Mobile",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
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
                  DropDown(
                    'Agency ',
                    Colors.grey.shade500,
                    Colors.black,
                    Colors.black,
                    10.0,
                    items: const ['Agency', 'Clerk', 'Passenger'],
                    callbackDropDown: (String newValue) {},
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              myTextField(
                  size.width / 4.5,
                  size.width / 1.10,
                  email,
                  false,
                  const Icon(
                    Icons.email_outlined,
                    color: Colors.white,
                  ),
                  'Email Address...',
                  TextInputType.emailAddress),
              const SizedBox(
                height: 20,
              ),
              myTextField(
                  size.width / 4.5,
                  size.width / 1.10,
                  password,
                  true,
                  const Icon(
                    Icons.lock_outline,
                    color: Colors.white,
                  ),
                  // SizedBox(
                  //   width: 113,
                  //   child: Icon(
                  //     Icons.lock_outline,
                  //     color: Colors.white.withOpacity(.8),
                  //   ),
                  // ),
                  'Password...',
                  TextInputType.text),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Already have an Account?',
                          style: GoogleFonts.adamina(
                            textStyle:
                                const TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const SignInScreen()),
                              );
                            },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              LinearSignUpButton(email: email, password: password),
              const SizedBox(
                height: 40,
              ),
              Center(
                  child: Text(
                "Book your Journeys Online",
                style: GoogleFonts.lobster(
                    textStyle: const TextStyle(fontSize: 25, color: Colors.white)),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
