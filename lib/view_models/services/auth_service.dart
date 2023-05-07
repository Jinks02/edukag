import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<UserCredential?> signUp(String email, String password, String name);

  Future<UserCredential?> logIn(String email, String password);

  Future<UserCredential?> signInWithGoogle();

  Future<String> signInWithPhoneNumber(String phoneNumber);

  Future<UserCredential?> signInWithOTP(String verificationId, String smsCode);

  Future<void> signOut();

  Future<UserCredential?> signInWithApple();

  final User? currentUser = FirebaseAuth.instance.currentUser;
}
