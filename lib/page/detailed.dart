import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_recipe/page/RecipeListExpanded.dart';

class detailed extends StatefulWidget {
  final String tapID;
  detailed({required this.tapID});

  @override
  State<detailed> createState() => _detailedState();
}

class _detailedState extends State<detailed> {
  final user = FirebaseAuth.instance.currentUser!;

  List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance.collection('Recipe').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            docIDs.add(document.reference.id);
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getDocId(),
            builder: (context, snapshot) {
              return SizedBox(
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Flexible(
                        child: ListTile(
                          title: getRecipesdetailed(
                            documentId: widget.tapID,
                          ),
                        ),
                      );
                    }),
              );
            },
          )),
        ],
      ),
    );
  }
}

/* Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: FutureBuilder(
            future: getDocId(),
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: docIDs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: GetRecipes(
                        documentId: docIDs[index],
                      ),
                    );
                  });
            },
          )),
        ],
      )),
    );
  }*/