import 'package:edukag/view_models/services/auth_service.dart';
import 'package:edukag/view_models/services/auth_service_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class SignUpViewModel extends ChangeNotifier {
  final AuthService _authService = AuthServiceImpl();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<UserCredential?> signUpWithEmailAndPassword(
      String email, String password, String name) async {
    _isLoading = true;
    notifyListeners();
    UserCredential? userCredential =
        await _authService.signUp(email, password, name);
    _isLoading = false;
    notifyListeners();
    return userCredential;
  }
}
