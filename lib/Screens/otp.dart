import 'dart:ui';
import 'package:fbissalama/Services/auth.dart';
import 'package:fbissalama/Widgets/OTP/otp_text_button.dart';
import 'package:fbissalama/Widgets/widgets/custom_snack_bar.dart';
import 'package:fbissalama/models/verifying.dart';
import 'package:fbissalama/utilities/assets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OTP extends StatelessWidget {
  final String number;

  const OTP({required this.number, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth().verifyPhoneNumber(context, number);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  AppAssets.backgroundOtp,
                ),
              ),
            ),
            height: size.height,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 3, sigmaX: 3),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Verifying:',
                      style: GoogleFonts.sahitya(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Color(0xFF37474F))),
                    ),
                    Text(
                      number,
                      style: GoogleFonts.sahitya(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Color(0xFFFFC727))),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'This code will expired after:',
                          style: GoogleFonts.sahitya(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Color(0xFF37474F)),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Countdown(
                          seconds: 60,
                          build: (BuildContext context, double time) => Text(
                            '00:00:${time.round().toString().padLeft(2, "0")}',
                            style: GoogleFonts.sahitya(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Color(0xFFFFC727)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Consumer<Verifying>(
                        builder: (context, value, child) => PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(10),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            inactiveFillColor: Colors.white54,
                            inactiveColor: Colors.blueGrey,
                            selectedColor: Colors.grey.shade700,
                            selectedFillColor: Colors.yellow.shade100,
                            activeFillColor: Colors.green.shade100,
                            activeColor: Colors.greenAccent.shade400,
                          ),
                          cursorColor: Colors.brown,
                          enableActiveFill: true,
                          controller: value.code,
                          keyboardType: TextInputType.number,
                          boxShadows: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                          onCompleted: (v) async {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithCredential(
                                      PhoneAuthProvider.credential(
                                          verificationId:
                                              value.verificationCode,
                                          smsCode: v))
                                  .then((value) {
                                if (value.user != null) {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/home');
                                }
                              });
                            } catch (e) {
                              FocusScope.of(context).unfocus();
                              customSnackBar(context, 'Invalid OTP Code', 3,
                                  Colors.white24, Colors.brown, 17);
                            }
                          },
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            otpTextButton(
                                "Didn't you receive any code?", () {}),
                            otpTextButton("Resend New Code?", () {}),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
