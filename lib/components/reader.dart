import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_demo1/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReaderPage extends StatefulWidget {
  final String mangaId;
  final String chapterId;

  ReaderPage({Key? key, required this.mangaId, required this.chapterId})
      : super(key: key);

  @override
  _ReaderPageState createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  @override
  void initState() {
    print("chapter id is " + widget.chapterId.toString());
    // TODO: implement initState
    super.initState();
  }

  int currentPage = 0;

  void goToPreviousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.textColor,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: MyColors.textColor,
        elevation: 0,
        iconTheme: IconThemeData(color: MyColors.primaryColor),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('mangas')
            .doc(widget.mangaId)
            .collection('chapters')
            .doc(widget.chapterId)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load manga details.'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No manga data available.'));
          } else {
            final manga = snapshot.data!.data() as Map<String, dynamic>?;
            if (manga == null || !manga.containsKey('imageURLs')) {
              return const Center(child: Text('Chapter images not found.'));
            }
            final imageURLs = List<String>.from(manga['imageURLs']);
            return Column(
              children: [
                SizedBox(
                  height: 500,
                  width: 350,
                  child: CachedNetworkImage(
                    imageUrl: imageURLs[currentPage],
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Page Number: $currentPage',
                  style: TextStyle(color: MyColors.primaryColor),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.textColor,
                      ),
                      onPressed: goToPreviousPage,
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        size: 30,
                      ),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.textColor,
                      ),
                      onPressed: () {
                        if (currentPage < imageURLs.length - 1) {
                          setState(() {
                            currentPage++;
                          });
                        }
                      },
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
