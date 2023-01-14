import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static Future<User?> signInWithGoogle(BuildContext context) async {
    User? user;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    // Trigger the authentication flow
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    // Obtain the auth details from the request
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount.authentication;
      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication!.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final userCredential =
            (await FirebaseAuth.instance.signInWithCredential(credential)).user;
        user = userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account exist with diff credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            AuthService.customSnackBar(
              content:
                  'The account already exists with a different credential.',
            ),
          );
        } else if (e.code == 'invalid credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            AuthService.customSnackBar(
              content: 'Error occurred while accessing credentials. Try again.',
            ),
          );
        }
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          AuthService.customSnackBar(
            content: 'Error occurred using Google Sign-In. Try again.',
          ),
        );
      }
    }
    // Once signed in, return the UserCredential
    return user;
  }

  static Future<User?> signInWithGoogleWeb(BuildContext context) async {
    User? user;
    // Create a new provider
    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      authProvider.setCustomParameters({'login_hint': 'user@example.com'});

      try {
        final userCredential =
            // Once signed in, return the UserCredential
            (await FirebaseAuth.instance.signInWithPopup(authProvider)).user;
        user = userCredential;
      } catch (e) {
        print(e);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final userCredential =
              // Once signed in, return the UserCredential
              (await FirebaseAuth.instance.signInWithCredential(authCredential))
                  .user;
          user = userCredential;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account exist with diff credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              AuthService.customSnackBar(
                content:
                    'The account already exists with a different credential.',
              ),
            );
          } else if (e.code == 'invalid credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              AuthService.customSnackBar(
                content:
                    'Error occurred while accessing credentials. Try again.',
              ),
            );
          }
        } catch (e) {
          print(e.toString());
          ScaffoldMessenger.of(context).showSnackBar(
            AuthService.customSnackBar(
              content: 'Error occurred using Google Sign-In. Try again.',
            ),
          );
        }
      }
    }
    return user;
  }

  static Future<void> signOut(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        AuthService.customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }

  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }
}
