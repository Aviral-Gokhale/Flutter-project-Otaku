import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo1/components/colors.dart';
import 'package:firebase_demo1/screens/firstPage.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class Hidden_Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SimpleHiddenDrawer(
        slidePercent: 35,
        menu: Menu(),
        screenSelectedBuilder: (position, controller) {
          Widget screenCurrent;

          switch (position) {
            case 0:
              //screenCurrent = const HomePage();
              break;
            case 1:
              //screenCurrent = SearchPage();
              break;
            case 2:
              //screenCurrent = const FavMangaPage();
              break;
            default:
            //screenCurrent = Container(); // Handle unknown position gracefully
          }

          return Scaffold(
            backgroundColor: Colors.orange,
            extendBody: true,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  controller.toggle();
                },
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Stack(
                children: [
                  Text(
                    'Otaku',
                    style: TextStyle(
                        color: MyColors.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 29,
                        fontFamily: 'Schyler'),
                  ),
                  Text(
                    'Otaku',
                    style: TextStyle(
                        color: MyColors.accentColor,
                        fontSize: 30,
                        fontFamily: 'Schyler'),
                  ),
                ],
              ),
            ),
            //body: screenCurrent,
          );
        },
      ),
    );
  }
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late SimpleHiddenDrawerController controller;

  @override
  void didChangeDependencies() {
    controller = SimpleHiddenDrawerController.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.orange[400],
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shadowColor: Colors.transparent,
                backgroundColor: Colors.transparent),
            onPressed: () {
              controller.setSelectedMenuPosition(0);
            },
            child: const Row(
              children: [
                Text(
                  "Home",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 14.5,
                ),
                Icon(Icons.arrow_right_outlined)
              ],
            ),
          ),
          const Divider(
            color: Colors.white,
            height: 0,
            endIndent: 250,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
            ),
            onPressed: () {
              controller.setSelectedMenuPosition(1);
            },
            child: const Row(
              children: [
                Text(
                  "Search",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(Icons.arrow_right_outlined)
              ],
            ),
          ),
          const Divider(
            color: Colors.white,
            height: 0,
            endIndent: 250,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
            ),
            onPressed: () {
              controller.setSelectedMenuPosition(2);
            },
            child: const Row(
              children: [
                Text(
                  "Favorite",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.arrow_right_outlined)
              ],
            ),
          ),
          const Divider(
            color: Colors.white,
            height: 0,
            endIndent: 250,
          ),
          SignOutButton(
            context: context,
          )
        ],
      ),
    );
  }
}

class SignOutButton extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final BuildContext context;

  SignOutButton({required this.context});

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FirstPage(),
        ),
      );
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      onPressed: _signOut,
      child: const Row(
        children: [
          Text(
            "Sign Out",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Icon(Icons.exit_to_app)
        ],
      ),
    );
  }
}












// class HiddenMenu extends StatefulWidget {
//   const HiddenMenu({super.key});

//   @override
//   State<HiddenMenu> createState() => _HiddenMenuState();
// }

// class _HiddenMenuState extends State<HiddenMenu> {
//   List<ScreenHiddenDrawer> _screens = [];

//   @override
//   void initState() {
//     super.initState();

//     _screens = [
//       ScreenHiddenDrawer(
//         ItemHiddenMenu(
//           name: 'Home',
//           baseStyle: const TextStyle(),
//           selectedStyle: const TextStyle(),
//         ),
//         const HomePage(),
//       ),
//       ScreenHiddenDrawer(
//         ItemHiddenMenu(
//           name: 'Search',
//           baseStyle: const TextStyle(),
//           selectedStyle: const TextStyle(),
//         ),
//         SearchPage(),
//       ),
//       ScreenHiddenDrawer(
//         ItemHiddenMenu(
//           name: 'Fav',
//           baseStyle: const TextStyle(),
//           selectedStyle: const TextStyle(),
//         ),
//         const FavMangaPage(),
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return HiddenDrawerMenu(
//       screens: _screens,
//       backgroundColorMenu: MyColors.accentColor,
//       initPositionSelected: 0,
//       slidePercent: 40,
//     );
//   }
// }
