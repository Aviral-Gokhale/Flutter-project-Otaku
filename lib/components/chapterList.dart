import 'package:firebase_demo1/components/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo1/components/reader.dart';
import 'package:flutter/material.dart';

class ChaptersList extends StatefulWidget {
  final String mangaId;

  const ChaptersList({Key? key, required this.mangaId}) : super(key: key);

  @override
  State<ChaptersList> createState() => _ChaptersListState();
}

class _ChaptersListState extends State<ChaptersList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection("mangas")
          .doc(widget.mangaId)
          .collection("chapters")
          .get(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('No chapters available.');
        } else {
          final chapters = snapshot.data!.docs;
          return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            itemCount: chapters.length,
            itemBuilder: (context, index) {
              final chapterData =
                  chapters[index].data() as Map<String, dynamic>;
              final chapterNumber = index + 1; //(index + 1).toString();

              return ListTile(
                onTap: () {
                  // print(chapterNumber);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReaderPage(
                        mangaId: widget.mangaId,
                        chapterId: chapterNumber.toString(),
                      ),
                    ),
                  );
                },
                title: Column(
                  children: [
                    Center(
                      child: Text(
                        'Chapter $chapterNumber',
                        style: TextStyle(
                            color: MyColors.textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
