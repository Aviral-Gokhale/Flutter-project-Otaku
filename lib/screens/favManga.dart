import 'package:firebase_demo1/components/colors.dart';
import 'package:firebase_demo1/components/grid.dart';
import 'package:flutter/material.dart';

class FavMangaPage extends StatefulWidget {
  const FavMangaPage({super.key});

  @override
  State<FavMangaPage> createState() => _FavMangaPageState();
}

class _FavMangaPageState extends State<FavMangaPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        resizeToAvoidBottomInset: false,
        backgroundColor: MyColors.primaryColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.transparent),
          backgroundColor: MyColors.accentColor,
          centerTitle: true,
          title: const Stack(
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
        ),
        body: Flex(
          direction: Axis.vertical,
          children: [
            Flexible(
              flex: 9,
              child: Container(
                color: MyColors.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridManga(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
