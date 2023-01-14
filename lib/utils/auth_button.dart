import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/leader_screen.dart';
import 'package:quiz_app/services/auth_service.dart';
import 'package:quiz_app/utils/action_button.dart';

class AuthButton extends StatefulWidget {
  const AuthButton({super.key});

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user == null) {
        setState(() {
          _isLoggedIn = false;
        });
        return;
      }
      setState(() {
        _isLoggedIn = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn)
      return Column(
        children: [
          ActionButton(
            title: 'Leaderboard',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LeaderScreen(),
                ),
              );
            },
          ),
        ],
      );
    return ActionButton(
      isPrimary: false,
      title: 'Sign In with Google',
      onTap: () {
        if (kIsWeb) {
          AuthService.signInWithGoogleWeb(context);
          return;
        }
        AuthService.signInWithGoogle(context);
      },
    );
  }
}
