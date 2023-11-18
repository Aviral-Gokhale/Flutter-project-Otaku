import 'dart:ui';
import 'package:firebase_demo1/components/bottom_Nav_bar.dart';
import 'package:firebase_demo1/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black45,
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    // background image
                    image: AssetImage(
                        'assets/images/naruto-wallpaper-download.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.white10,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Stack(
                      children: [
                        Text(
                          'Otaku',
                          style: TextStyle(
                              color: MyColors.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              fontFamily: 'Schyler'),
                        ),
                        Text(
                          'Otaku',
                          style: TextStyle(
                              color: MyColors.accentColor,
                              fontSize: 33,
                              fontFamily: 'Schyler'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.3), // Shadow color
                            offset: const Offset(
                                0, 0), // Offset (horizontal, vertical)
                            blurRadius: 5, // Blur radius
                            spreadRadius: 3, // Spread radius
                          ),
                        ],
                      ),
                      width: 340,
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: '    Email',
                          labelStyle:
                              const TextStyle(color: MyColors.textColor),
                          suffixIcon: const Icon(Icons.mail_outline),
                          suffixIconColor: Colors.black54,
                          border: const UnderlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              width: 0.0, // Border width when not focused
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.white, // Border color when focused
                              width: 1.0, // Border width when focused
                            ),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(60.0),
                            borderSide: const BorderSide(
                              color: Colors
                                  .red, // Border color when there's an error
                              width: 2.0, // Border width when there's an error
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.3), // Shadow color
                            offset: const Offset(
                                0, 0), // Offset (horizontal, vertical)
                            blurRadius: 5, // Blur radius
                            spreadRadius: 3, // Spread radius
                          ),
                        ],
                      ),
                      width: 340,
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: '    Password',
                          labelStyle:
                              const TextStyle(color: MyColors.textColor),
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.visibility)),
                          border: const UnderlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(60),
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              width: 0.0, // Border width when not focused
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.white, // Border color when focused
                              width: 0.0, // Border width when focused
                            ),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors
                                  .red, // Border color when there's an error
                              width: 2.0, // Border width when there's an error
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: MyColors.accentColor,
                        elevation: 5, // Elevation (shadow)
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 10), // Button padding
                        textStyle: const TextStyle(
                          fontSize: 18, // Text font size
                        ),
                      ),
                      onPressed: () async {
                        final String email = _emailController.text;
                        final String password = _passwordController.text;

                        try {
                          await _auth.createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NavBar(),
                            ),
                          );
                        } catch (e) {
                          print('Error: $e');
                        }
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
