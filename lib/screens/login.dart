import 'dart:ui';
import 'package:firebase_demo1/components/bottom_Nav_bar.dart';
import 'package:firebase_demo1/components/colors.dart';
import 'package:firebase_demo1/screens/signup.dart';
import 'package:firebase_demo1/services/auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late AuthPage authPage;

  @override
  void initState() {
    super.initState();
    authPage =
        AuthPage(context); // Initialize AuthPage with context in initState
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
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
            Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 5,
                  child: Column(
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
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.white54,
                        ),
                        width: 340,
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: '    Email',
                            labelStyle: const TextStyle(
                              color: MyColors.textColor,
                            ),
                            suffixIcon: const Icon(Icons.mail_outline),
                            suffixIconColor: Colors.black54,
                            border: const UnderlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
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
                                color: Color(
                                    0xff221c1c), // Border color when focused
                                width: 0.0, // Border width when focused
                              ),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors
                                    .red, // Border color when there's an error
                                width: .0, // Border width when there's an error
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        width: 340,
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                              color: MyColors.textColor,
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.visibility),
                              onPressed: () {},
                            ),
                            suffixIconColor: Colors.black54,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors
                                    .white, // Border color when not focused
                                width: 0.0, // Border width when not focused
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color:
                                    Colors.white, // Border color when focused
                                width: 0.0, // Border width when focused
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors
                                    .red, // Border color when there's an error
                                width:
                                    2.0, // Border width when there's an error
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: MyColors.accentColor, // Text color
                          elevation: 5,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Button border radius
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10), // Button padding
                          textStyle: const TextStyle(
                            fontSize: 18, // Text font size
                          ),
                        ),
                        onPressed: () {
                          authPage.signInAuth(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NavBar()),
                          );
                        },
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Are you not registered?',
                        style: TextStyle(
                            color: MyColors.textColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 35,
                        width: 80,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign up!',
                            style: TextStyle(color: MyColors.primaryColor),
                          ),
                        ),
                      )
                    ],
                  ),
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
