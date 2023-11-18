import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo1/components/bottom_Nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthGoogle {
  Future<User?> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    // Navigate to the HomePage after successful sign-in
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NavBar(),
      ),
    );

    // Return the signed-in user
    return FirebaseAuth.instance.currentUser;
  }
}
