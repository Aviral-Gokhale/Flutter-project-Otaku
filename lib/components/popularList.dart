import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo1/components/colors.dart';
import 'package:firebase_demo1/screens/theMangaPage.dart';
import 'package:flutter/material.dart';

class PopularList extends StatefulWidget {
  const PopularList({Key? key}) : super(key: key);

  @override
  _PopularListState createState() => _PopularListState();
}

class _PopularListState extends State<PopularList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("mangas").get(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('No data available.');
        } else {
          final mangaList = snapshot.data!.docs;
          return Container(
            height: 205,
            child: Center(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mangaList.length,
                itemBuilder: (context, index) {
                  final manga = mangaList[index].data() as Map<String, dynamic>;
                  final mangaName = manga['name'] as String;
                  // final genre = (manga['genre'] as List).cast<String>();
                  final cover = manga['coverimageURL'] as String;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TheMangaPage(
                            mangaId: mangaList[index].id,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 200,
                      width: 300,
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: MyColors.textColor,
                              spreadRadius: 1,
                              blurRadius: 4),
                        ],
                      ),
                      child: Center(
                        child: Stack(
                          children: [
                            Container(
                              height: 200,
                              width: 300,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(cover),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Container(
                              height: 200,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.transparent, Colors.black54],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    mangaName,
                                    style: const TextStyle(
                                      color: MyColors.primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}


    /*SizedBox(
      height: 300,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TheMangaPage(
                          mangaId: '18N1U5b7Us1jU20x7Leq',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 400,
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1), // Shadow color
                          offset: const Offset(
                              0, 0), // Offset (horizontal, vertical)
                          blurRadius: 5, // Blur radius
                          spreadRadius: -3,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: 400,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/MangaCover.jpg'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                        Container(
                          width: 400,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black54],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Manga Name',
                                style: TextStyle(
                                    color: MyColors.primaryColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );*/
  

