import 'package:firebase_auth/firebase_auth.dart';
import 'package:note/data/service/auth_service.dart';

class AuthRepository {
  AuthRepository({required this.authService});

  final AuthService authService;

  User? get user => authService.user;

  Future<UserCredential?> logInOrRegister(
      {required String email, required String password}) {
    email = email.trim();
    password = password.trim();
    return authService.logInOrRegister(email: email, password: password);
  }

  Future<void> signOut() async => authService.signOut();
}
