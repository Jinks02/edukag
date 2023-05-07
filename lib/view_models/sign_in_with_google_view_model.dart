import 'package:edukag/view_models/services/auth_service.dart';
import 'package:edukag/view_models/services/auth_service_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class SignInWithGoogleViewModel extends ChangeNotifier {
  final AuthService _authService = AuthServiceImpl();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<UserCredential?> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();
    UserCredential? userCredential = await _authService.signInWithGoogle();
    _isLoading = false;
    notifyListeners();
    return userCredential;
  }
}
