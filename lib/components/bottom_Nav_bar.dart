import 'package:firebase_demo1/components/categories.dart';
import 'package:firebase_demo1/components/colors.dart';
import 'package:firebase_demo1/screens/favManga.dart';
import 'package:firebase_demo1/screens/home.dart';
import 'package:firebase_demo1/screens/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    allCategories(),
    FavMangaPage(),
    SearchPage(),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onItemTapped(int i) {
    _pageController.jumpToPage(i);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _screens,
      ),
      extendBody: true,
      bottomNavigationBar: SalomonBottomBar(
          selectedItemColor: MyColors.accentColor,
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home_outlined),
              title: const Text('Home'),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.category),
              title: const Text('Categories'),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.favorite_border),
              title: const Text('Favorite'),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.search),
              title: const Text('Search'),
            ),
          ]),
    );
  }
}


// DotNavigationBar(
//         backgroundColor: MyColors.accentColor,
//         onTap: _onItemTapped,
//         currentIndex: _selectedIndex,
//         items: [
//           /// Home
//           DotNavigationBarItem(
//             icon: const Icon(Icons.home),
//             selectedColor: Colors.purple,
//           ),

//           /// Likes
//           DotNavigationBarItem(
//             icon: const Icon(Icons.favorite_border),
//             selectedColor: Colors.pink,
//           ),

//           /// Search
//           DotNavigationBarItem(
//             icon: const Icon(Icons.search),
//             selectedColor: Colors.orange,
//           ),

//           /// Profile
//           DotNavigationBarItem(
//             icon: const Icon(Icons.person),
//             selectedColor: Colors.teal,
//           ),
//         ],
//       ),