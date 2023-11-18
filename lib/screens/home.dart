import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo1/components/colors.dart';
import 'package:firebase_demo1/components/grid.dart';
import 'package:firebase_demo1/components/popularList.dart';
import 'package:firebase_demo1/screens/firstPage.dart';
import 'package:firebase_demo1/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        resizeToAvoidBottomInset: false,
        backgroundColor: MyColors.primaryColor,
        appBar: AppBar(
          backgroundColor: MyColors.accentColor,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.transparent),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
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
                        color: MyColors.primaryColor,
                        fontSize: 33,
                        fontFamily: 'Schyler'),
                  ),
                ],
              ),
              IconButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => FirstPage()));
                  } catch (e) {
                    print('Error during logout: $e');
                  }
                },
                icon: const Icon(
                  Icons.logout,
                  color: MyColors.primaryColor,
                ),
              )
            ],
          ),
        ),
        body: Container(
          color: MyColors.primaryColor,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //const HomeTiles(),
                const SizedBox(
                  height: 10,
                ),
                PopularList(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    'Popular Manga:',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridManga(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
