import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo1/screens/home.dart';
import 'package:flutter/material.dart';

class AuthPage {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final BuildContext context;

  AuthPage(this.context);

  Future<void> signInAuth(BuildContext context) async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
