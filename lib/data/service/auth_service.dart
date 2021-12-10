import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  User? get user => FirebaseAuth.instance.currentUser;

  Future<UserCredential?> logInOrRegister(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
      } else {
        throw e.message!;
      }
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
