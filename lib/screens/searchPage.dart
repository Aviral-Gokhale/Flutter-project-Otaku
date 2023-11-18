import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo1/components/colors.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          backgroundColor: MyColors.primaryColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SearchWidget(),
        ),
      ),
    );
  }
}

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];

  void _performSearch(String query) {
    FirebaseFirestore.instance
        .collection("mangas") // Replace with your collection name
        .where('', isGreaterThanOrEqualTo: query)
        .get()
        .then((QuerySnapshot snapshot) {
      final results = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return data[''] as String;
      }).toList();

      setState(() {
        _searchResults = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Flexible(
          flex: 9,
          child: Container(
            color: MyColors.primaryColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (query) {
                      _performSearch(query);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      labelStyle: TextStyle(color: MyColors.accentColor),
                      prefixIcon: Icon(
                        Icons.search,
                        color: MyColors.accentColor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: MyColors.borderColor, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: _searchResults.isNotEmpty
                      ? ListView.builder(
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_searchResults[index]),
                            );
                          },
                        )
                      : const Center(
                          child: Text(
                            'No results found.',
                            style: TextStyle(
                              color: MyColors.accentColor,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
