import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo1/components/chapterList.dart';
import 'package:firebase_demo1/components/colors.dart';
import 'package:firebase_demo1/components/description.dart';
import 'package:flutter/material.dart';

class TheMangaPage extends StatefulWidget {
  final String mangaId;

  const TheMangaPage({
    Key? key,
    required this.mangaId,
  }) : super(key: key);

  @override
  State<TheMangaPage> createState() => _TheMangaPageState();
}

class _TheMangaPageState extends State<TheMangaPage> {
  @override
  void initState() {
    // TODO: implement initState
    print("chapter id is");
    print(widget.mangaId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: MyColors.accentColor,
          iconTheme: IconThemeData(color: MyColors.primaryColor),
        ),
        body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("mangas")
              .doc(widget.mangaId)
              .get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Failed to load manga details.'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No manga data available.'));
            } else {
              final manga = snapshot.data!.data() as Map;
              final mangaName = manga['name'] as String;
              final mangaAuthor = manga['author'] as String;
              final genre = (manga['genre'] as List).cast<String>();
              final cover = manga['coverimageURL'] as String;
              return ListView(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(cover),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.transparent,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: 135,
                                height: 200,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: MyColors.textColor,
                                        spreadRadius: 2,
                                        blurRadius: 20)
                                  ],
                                  // borderRadius: const BorderRadius.only(
                                  //   bottomLeft: Radius.circular(30),
                                  // ),
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                    image: NetworkImage(cover),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                children: [
                                  Center(
                                    child: Text(
                                      mangaName,
                                      style: const TextStyle(
                                        color: MyColors.textColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'By: $mangaAuthor',
                                    style: const TextStyle(
                                      color: MyColors.textColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Genres: ${genre.join(', ')}',
                                    style: const TextStyle(
                                      color: MyColors.textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: MyColors.accentColor,
                          backgroundColor: MyColors.primaryColor,
                          elevation: 4,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 10,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Description(mangaId: widget.mangaId),
                            ),
                          );
                        },
                        child: Text('Description'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: MyColors.accentColor,
                          backgroundColor: MyColors.primaryColor,
                          elevation: 4,
                          shadowColor: Colors.black,
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 35,
                            vertical: 9,
                          ),
                        ),
                        onPressed: () {},
                        child: const Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: MyColors.accentColor,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: MyColors.accentColor,
                          backgroundColor: MyColors.primaryColor,
                          elevation: 4,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 35,
                            vertical: 9,
                          ),
                        ),
                        onPressed: () {},
                        child: Icon(
                          Icons.download,
                          color: MyColors.accentColor,
                        ),
                      ),
                    ],
                  ),
                  ChaptersList(
                    mangaId: widget.mangaId,
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
        



// ListView(
//               children: [
//                 Stack(
//                   children: [
//                     Container(
//                       decoration: const BoxDecoration(
//                         //this is the cover image
//                         image: DecorationImage(
//                           image: AssetImage('assets/images/MangaCover.jpg'),
//                           fit: BoxFit.cover,
//                         ),
//                         color: Colors.transparent,
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(30),
//                           bottomRight: Radius.circular(30),
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: MyColors.textColor,
//                             blurRadius: 5,
//                             spreadRadius: 4,
//                             offset: Offset(0, -3),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       decoration: const BoxDecoration(
//                         color: Colors.black54,
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(30),
//                           bottomRight: Radius.circular(30),
//                         ),
//                       ),
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Row(
//                           children: [
//                             Container(
//                               width: 135,
//                               height: 200,
//                               decoration: const BoxDecoration(
//                                 borderRadius: BorderRadius.only(
//                                   bottomLeft: Radius.circular(30),
//                                 ),
//                                 color: Colors.transparent,
//                                 image: DecorationImage(
//                                   //this is also cover image
//                                   image: AssetImage(
//                                       'assets/images/MangaCover.jpg'),
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 20,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   mangaTitle,
//                                   style: const TextStyle(
//                                     color: MyColors.primaryColor,
//                                     fontSize: 25,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Text(
//                                   'Author: $mangaAuthor', // Display manga author
//                                   style: const TextStyle(
//                                     color: MyColors.primaryColor,
//                                     fontSize: 20,
//                                   ),
//                                 ),
//                                 Text(
//                                   'Genres: ${mangaGenre.join(', ')}',
//                                   style: const TextStyle(
//                                     color: MyColors.primaryColor,
//                                     fontSize: 20,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     //this the description of the image
//                     const Text('Summary'),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: MyColors.accentColor,
//                         backgroundColor: MyColors.primaryColor,
//                         elevation: 4,
//                         shadowColor: Colors.black,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 20,
//                           vertical: 10,
//                         ),
//                         textStyle: const TextStyle(
//                           fontSize: 18,
//                         ),
//                       ),
//                       onPressed: () {},
//                       child: const Row(
//                         children: [
//                           Icon(
//                             Icons.favorite,
//                             color: MyColors.accentColor,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 ChaptersList(
//                   mangaId: widget.mangaId,
//                 ),
//               ],
//             );

// floatingActionButton: FloatingActionButton(
//           backgroundColor: MyColors.accentColor,
//           onPressed: () {},
//           child: const Icon(
//             Icons.play_arrow,
//             color: MyColors.primaryColor,
//             size: 30,
//           ),
//         ),