import 'package:firebase_demo1/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class allCategories extends StatefulWidget {
  const allCategories({super.key});

  @override
  _allCategoriesState createState() => _allCategoriesState();
}

class _allCategoriesState extends State<allCategories> {
  late Stream<QuerySnapshot> categoriesStream;

  @override
  void initState() {
    super.initState();

    // Fetch categories data from Firebase Firestore
    categoriesStream =
        FirebaseFirestore.instance.collection('mangas').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.transparent),
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
        centerTitle: true,
        backgroundColor: MyColors.accentColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: categoriesStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No categories available.'));
          }

          final categories = snapshot.data!.docs;

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index].data() as Map<String, dynamic>;
              final categoryName = category['name'] as String;

              return InkWell(
                onTap: () {
                  // Handle category selection, navigate to a specific category page, etc.
                },
                child: Card(
                  elevation: 2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          categoryName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
