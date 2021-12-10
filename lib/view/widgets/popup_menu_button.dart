import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note/data/repository/auth_repository.dart';
import 'package:note/utils/constants.dart';

class UserPopupMenuButton extends StatelessWidget {
  const UserPopupMenuButton({Key? key, required this.authRepository})
      : super(key: key);

  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white,
      itemBuilder: (context) => [
        userPopupMenuItem(),
        signOutPopupMenuItem(context),
      ],
      icon: Icon(Icons.person),
    );
  }

  PopupMenuItem<String> signOutPopupMenuItem(BuildContext context) {
    return PopupMenuItem<String>(
      onTap: () async {
        await signOut(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Sign out'),
          Icon(Icons.logout, color: Colors.grey.shade800),
        ],
      ),
    );
  }

  PopupMenuItem<String> userPopupMenuItem() {
    return PopupMenuItem<String>(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(FirebaseAuth.instance.currentUser!.email!.split('@')[0]),
          Icon(Icons.person, color: Colors.grey.shade800),
        ],
      ),
    );
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await authRepository.signOut();
      Navigator.pushReplacementNamed(context, AUTH_ROUTE);
    } catch (err) {
      // print(err);
    }
  }
}
