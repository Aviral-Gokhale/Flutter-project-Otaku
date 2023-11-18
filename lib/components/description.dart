import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo1/components/colors.dart';
import 'package:flutter/material.dart';

class Description extends StatefulWidget {
  final String mangaId;

  const Description({super.key, required this.mangaId});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.accentColor,
        iconTheme: IconThemeData(color: MyColors.primaryColor),
        title: Text(
          'Description',
          style: TextStyle(color: MyColors.primaryColor),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("mangas")
            .doc(widget.mangaId)
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final manga = snapshot.data!.data() as Map;
            final descrip = manga['description'] as String;
            return Container(
              padding: EdgeInsets.all(15),
              child: Text(
                descrip,
                style: TextStyle(
                    color: MyColors.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            );
          }
        },
      ),
    );
  }
}
