import 'package:edukag/screens/get_started_view.dart';
import 'package:edukag/screens/home_view.dart';
import 'package:edukag/screens/splash_view.dart';
import 'package:edukag/view_models/home_view_model.dart';
import 'package:edukag/view_models/log_in_view_model.dart';
import 'package:edukag/view_models/otp_auth_view_model.dart';
import 'package:edukag/view_models/sign_in_with_apple_view_model.dart';
import 'package:edukag/view_models/sign_in_with_google_view_model.dart';
import 'package:edukag/view_models/sign_up_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(
          create: (context) => LoginViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => OtpAuthViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignInWithAppleViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignInWithGoogleViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignUpViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Edukag",
        theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            primaryColor: const Color.fromRGBO(255, 145, 77, 1),
            fontFamily: "Nunito"),
        initialRoute: '/splash',
        routes: {
// '/': (context) => SplashScreen(),
          '/home-screen': (context) => HomeScreen(),
          '/get-started': (context) => GetStarted(),
          '/splash': (context) => SplashScreen(),
        },
// home: SplashScreen(),
      ),
    );
  }
}
