import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // late VideoPlayerController _controller;
  // bool _isVideoInitialized = false;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    // _controller =
    // VideoPlayerController.asset('assets/videos/splash_video_light.mp4')
    //   ..initialize().then((_) {
    //     setState(() {
    //       _isVideoInitialized = true;
    //     });
    //     _controller.play();
    //   });

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    // Check if user has account
    bool hasAccount = checkIfUserHasAccount();
    log("hasAccount =$hasAccount");
    // Delay the navigation for 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to appropriate screen
      if (hasAccount) {
        Navigator.pushReplacementNamed(context, '/home-screen');
      } else {
        Navigator.pushReplacementNamed(context, '/get-started');
      }
    });

    // _controller =
    //     VideoPlayerController.asset('assets/videos/splash_video_light.mp4')
    //       ..initialize().then((_) {
    //         setState(() {
    //           _isVideoInitialized = true;
    //         });
    //         _controller.play();
    //       });
    //
    // _controller.addListener(() {
    //   if (_controller.value.position == _controller.value.duration) {
    //     Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(
    //         builder: (BuildContext context) => HomeScreen(),
    //       ),
    //     );
    //   }
    // });
  }

  bool checkIfUserHasAccount() {
    // Your code to check if the user has an account
    // Return true if user has account, false otherwise

    if (auth.currentUser == null) {
      log("user does not exist");
      return false;
    } else {
      log("user exist");
      log(auth.currentUser?.email.toString() ?? "no email");

      return true;
    }
  }

  // void checkUserLogin() {
  //   if (auth.currentUser == null) {
  //     log("user does not exists");
  //     _controller.addListener(() {
  //       if (_controller.value.position == _controller.value.duration) {
  //         Navigator.of(context).pushReplacement(
  //           MaterialPageRoute(
  //             builder: (BuildContext context) => GetStarted(), //change to GetStarted() after testing
  //           ),
  //         );
  //       }
  //     });
  //   } else {
  //     log("user exists");
  //     log(auth.currentUser?.email.toString() ?? "no email");
  //     _controller.addListener(() {
  //       if (_controller.value.position == _controller.value.duration) {
  //         Navigator.of(context).pushReplacement(
  //           MaterialPageRoute(
  //             builder: (BuildContext context) => HomeScreen(),
  //           ),
  //         );
  //       }
  //     });
  //   }
  // }

  // @override
  // void dispose() {
  //   // _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeInImage(
          fadeInDuration: Duration(milliseconds: 500),
          placeholder: AssetImage('assets/images/edukag.png'),
          image: AssetImage('assets/images/edukag.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// OrientationBuilder(builder: (context, orientation) {
// if (orientation == Orientation.landscape) {
// return SingleChildScrollView(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// if (_isVideoInitialized)
// AspectRatio(
// aspectRatio: _controller.value.aspectRatio,
// child: VideoPlayer(_controller),
// ),
// Container(
// transform: Matrix4.translationValues(0.0, -50.0, 0.0),
// child: const Text(
// "Skip the queue, pay with ease!",
// style: TextStyle(
// fontSize: 18,
// fontFamily: "Nunito",
// fontWeight: FontWeight.bold),
// ), //Image.asset('assets/app_logo.png'),
// ),
// ],
// ),
// );
// } else {
// return Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// if (_isVideoInitialized)
// AspectRatio(
// aspectRatio: _controller.value.aspectRatio,
// child: VideoPlayer(_controller),
// ),
// Container(
// transform: Matrix4.translationValues(0.0, 0.0, 0.0),
// child: const Text(
// "Skip the queue, pay with ease!",
// style: TextStyle(
// fontSize: 18,
// fontFamily: "Nunito",
// fontWeight: FontWeight.bold),
// ), //Image.asset('assets/app_logo.png'),
// ),
// ],
// );
// }
// })
