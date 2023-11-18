import 'package:firebase_demo1/components/categories.dart';
import 'package:firebase_demo1/components/colors.dart';
import 'package:flutter/material.dart';

class HomeTiles extends StatefulWidget {
  const HomeTiles({Key? key});

  @override
  State<HomeTiles> createState() => _HomeTilesState();
}

var genres = [
  'All',
  'Categories',
];

class _HomeTilesState extends State<HomeTiles> {
  int selectedGenreIndex = 0; // Maintain the selected genre index

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 30,
          margin: const EdgeInsets.only(left: 10),
          child: ListView(
            scrollDirection: Axis.horizontal, // Make the list horizontal
            children: [
              for (var index = 0; index < genres.length; index++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        selectedGenreIndex = index; // Update the selected index
                      });
                      print('Genre selected: ${genres[index]}');
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: selectedGenreIndex == index
                          ? Colors.orange[50]
                          : Colors
                              .black12, // Change background color when selected
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: BorderSide(
                        color: selectedGenreIndex == index
                            ? MyColors
                                .accentColor // Change border color when selected
                            : MyColors.textColor,
                      ),
                    ),
                    child: Text(
                      genres[index],
                      style: TextStyle(
                        fontSize: 15,
                        color: selectedGenreIndex == index
                            ? MyColors.accentColor
                            : MyColors
                                .textColor, // Change text color when selected
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (selectedGenreIndex ==
            1) // Show all categories when 'Categories' is selected
          allCategories(),
      ],
    );
  }
}
