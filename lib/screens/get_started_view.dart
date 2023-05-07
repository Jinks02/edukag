import 'package:edukag/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../view_models/sign_in_with_google_view_model.dart';
import 'home_view.dart';
import 'login.dart';
import 'otp_phone_number_view.dart';

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                width: double.infinity,
                child: Image.asset('assets/images/get_started.png')),
            Container(
              child: Column(
                children: [
                  Container(
                    child: const Text(
                      "Get Started with Edukag",
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  // Container(
                  //   margin: const EdgeInsets.only(bottom: 50, top: 30),
                  //   child: const Text(
                  //     "Ger your groceries in as fast as one hour",
                  //     style: TextStyle(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.grey),
                  //   ),
                  // ),
                  SizedBox(
                    height: 60,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                        ),
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            print("Button Clicked");
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (builder) => const LoginPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              "Log in",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0, bottom: 48),
                        child: UnconstrainedBox(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xffE3DEDE),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Theme(
                                  data: ThemeData(
                                      platform: defaultTargetPlatform),
                                  child: defaultTargetPlatform ==
                                          TargetPlatform.android
                                      ? Consumer<SignInWithGoogleViewModel>(
                                          builder: (context, value, child) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 28.0),
                                            child: InkWell(
                                              onTap: () async {
                                                debugPrint(
                                                    "google icon clicked");
                                                UserCredential? userCredential =
                                                    await value
                                                        .signInWithGoogle();
                                                if (userCredential != null) {
                                                  // todo: find an alternative to scaffold messenger
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          backgroundColor:
                                                              Colors.orange,
                                                          content: Text(
                                                              "google sign in success")));
                                                  Navigator.push(
                                                      (context),
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomeScreen()));
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          backgroundColor:
                                                              Colors.orange,
                                                          content: Text(
                                                              "google sign in failed")));
                                                }
                                              },
                                              child: value.isLoading
                                                  ? const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 28.0),
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 28.0),
                                                      child: SvgPicture.asset(
                                                        'assets/images/google_logo.svg',
                                                        width: 40,
                                                        height: 40,
                                                      ),
                                                    ),
                                            ),
                                          );
                                        })
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(right: 28),
                                          child: InkWell(
                                            onTap: () {
                                              debugPrint("apple icon clicked");
                                            },
                                            child: SvgPicture.asset(
                                              'assets/images/apple_logo_dark.svg',
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 28.0),
                                  child: InkWell(
                                    onTap: () {
                                      debugPrint("phone icon clicked");
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              OtpPhoneNumberView(),
                                        ),
                                      );
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.orange,
                                      radius: 22,
                                      child: Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
