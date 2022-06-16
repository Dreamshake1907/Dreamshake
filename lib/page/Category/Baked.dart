import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_recipe/page/RecipeListExpanded.dart';

class Baked extends StatefulWidget {
  const Baked({Key? key}) : super(key: key);

  @override
  State<Baked> createState() => _BakedState();
}

class _BakedState extends State<Baked> {
  List<String> docIDs = [];

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: FutureBuilder(
            future: Baked(),
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
      )),
    );
  }

  Future Baked() async {
    await FirebaseFirestore.instance
        .collection('Recipe')
        .where('Recipe Category', isEqualTo: 'Baked')
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            docIDs.add(document.reference.id);
          }),
        );
  }
}
