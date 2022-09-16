import 'dart:ui';

import 'package:fbissalama/Screens/MainHomeScreen/MainHomeScreen.dart';
import 'package:fbissalama/Widgets/OTP/timer.dart';
import 'package:fbissalama/utilities/assets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OTP extends StatefulWidget {
  final String number;

  const OTP({required this.number, Key? key}) : super(key: key);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinOTPCodeController = TextEditingController();
  final FocusNode _pinOTPCodeFoucus = FocusNode();
  String? varificationCode;

  final BoxDecoration pinOTPCodeDecoration = BoxDecoration(
      color: Color(0xFFA6A6A6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFC727)));

  void initState() {
    super.initState();
    verifyPhoneNumber();
  }

  verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '${widget.number}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) {
          if (value.user != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MainHome(),
              ),
            );
          }
        });
      },
      verificationFailed: (FirebaseException e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message.toString()),
            duration: const Duration(seconds: 3)));
      },
      codeSent: (String vID, int? resendToken) {
        setState(() {
          varificationCode = vID;
        });
      },
      codeAutoRetrievalTimeout: (String vID) {
        setState(() {});
      },
      timeout: const Duration(seconds: 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  AppAssets.backgroundOtp2,
                ),
              ),
            ),
            height: size.height,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 3, sigmaX: 3),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35),
                    child: GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Verifying:',
                                style: GoogleFonts.sahitya(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: Color(0xFF37474F))),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${widget.number}',
                                style: GoogleFonts.sahitya(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Color(0xFFFFC727))),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TimerApp(),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: PinPut(
                          fieldsCount: 6,
                          textStyle: const TextStyle(
                              fontSize: 25.0, color: Colors.white),
                          eachFieldWidth: 45.0,
                          eachFieldHeight: 50.0,
                          focusNode: _pinOTPCodeFoucus,
                          controller: _pinOTPCodeController,
                          submittedFieldDecoration: pinOTPCodeDecoration,
                          selectedFieldDecoration: pinOTPCodeDecoration,
                          followingFieldDecoration: pinOTPCodeDecoration,
                          onSubmit: (pin) async {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithCredential(
                                      PhoneAuthProvider.credential(
                                          verificationId: varificationCode!,
                                          smsCode: pin))
                                  .then((value) {
                                if (value.user != null) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const MainHome()));
                                }
                              });
                            } catch (e) {
                              FocusScope.of(context).unfocus();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Invalid OTP'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Didn't you receive any code?",
                                  style: TextStyle(
                                    backgroundColor: Color(0xFFFFFFFF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFFC727),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Resend New Code?",
                                  style: TextStyle(
                                    backgroundColor: Color(0xFFFFFFFF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFFC727),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
