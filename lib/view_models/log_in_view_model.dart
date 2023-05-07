import 'package:edukag/view_models/services/auth_service.dart';
import 'package:edukag/view_models/services/auth_service_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthServiceImpl();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    _isLoading = true;
    notifyListeners();
    UserCredential? userCredential = await _authService.logIn(email, password);
    _isLoading = false;
    notifyListeners();
    return userCredential;
  }
}
