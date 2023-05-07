import 'dart:developer';

import 'package:edukag/view_models/services/auth_service.dart';
import 'package:edukag/view_models/services/auth_service_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class OtpAuthViewModel extends ChangeNotifier {
  AuthService authService = AuthServiceImpl();

  // OtpAuthViewModel({required this.authService});

  String verificationId = '';

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<String?> verifyPhoneNumber(String phoneNumber) async {
    try {
      setLoading(true);
      await authService
          .signInWithPhoneNumber(phoneNumber)
          .then((value) => verificationId = value);
      log("view model ver id= ${verificationId.isEmpty}");
      setLoading(false);
    } catch (e) {
      print(e.toString());
    }
    return verificationId;
  }

  Future<UserCredential?> signInWithOTP(
      String verificationId, String smsCode) async {
    final UserCredential? userCredential;
    try {
      setLoading(true);
      userCredential = await authService.signInWithOTP(verificationId, smsCode);
      setLoading(false);
      return userCredential;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}
