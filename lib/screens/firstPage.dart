import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo1/components/colors.dart';
import 'package:firebase_demo1/screens/home.dart';
import 'package:firebase_demo1/screens/login.dart';
import 'package:firebase_demo1/screens/signup.dart';
import 'package:firebase_demo1/services/google_signin.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    // Function to check if the user is already signed in
    Future<void> checkUser() async {
      final user = _auth.currentUser;
      if (user != null) {
        // User is signed in, navigate to the main app screen.
        // Example:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    }

    // Check if the user is already signed in when the app starts.
    checkUser();
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            Colors.black, // Set the background color of the Scaffold
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Stack(
                    children: [
                      Text(
                        'Otaku',
                        style: TextStyle(
                            color: MyColors.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            fontFamily: 'Schyler'),
                      ),
                      Text(
                        'Otaku',
                        style: TextStyle(
                            color: MyColors.accentColor,
                            fontSize: 41,
                            fontFamily: 'Schyler'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 300,
                  ),
                  ElevatedButton(
                    //login button
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.black,
                      backgroundColor: const Color(0xffff8b00),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 130, vertical: 8),
                      textStyle: const TextStyle(
                        fontSize: 18, // Text font size
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    //sign in button
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      shadowColor: Colors.black,
                      backgroundColor: Colors.white54,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 120, vertical: 8),
                      textStyle: const TextStyle(
                        fontSize: 18, // Text font size
                      ),
                    ),
                    child: const Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 42,
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.black,
                        backgroundColor: Colors.white,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        textStyle: const TextStyle(
                          fontSize: 18, // Text font size
                        ),
                      ),
                      onPressed: () async {
                        await AuthGoogle().signInWithGoogle(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/icons8-google-48.png'),
                          const SizedBox(width: 60),
                          const Text(
                            'Sign In with Google',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
