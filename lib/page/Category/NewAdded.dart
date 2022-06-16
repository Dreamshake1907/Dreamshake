import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_recipe/page/RecipeListExpanded.dart';

class newAdded extends StatefulWidget {
  const newAdded({Key? key}) : super(key: key);

  @override
  State<newAdded> createState() => _newAddedState();
}

class _newAddedState extends State<newAdded> {
  List<String> docIDs = [];

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: FutureBuilder(
            future: newAdded(),
            builder: (context, snapshot) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: docIDs.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 300,
                      width: width,
                      child: ListTile(
                        title: getRecipesTapped(
                          documentId: docIDs[index],
                        ),
                      ),
                    );
                  });
            },
          )),
        ],
      ),
    );
  }

  Future newAdded() async {
    await FirebaseFirestore.instance
        .collection('Recipe')
        .orderBy('createdAt', descending: true)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            docIDs.add(document.reference.id);
          }),
        );
  }
}
