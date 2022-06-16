import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../RecipeListExpanded.dart';

class Salads extends StatefulWidget {
  const Salads({Key? key}) : super(key: key);

  @override
  State<Salads> createState() => _SaladsState();
}

class _SaladsState extends State<Salads> {
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
            future: Salads(),
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

  Future Salads() async {
    await FirebaseFirestore.instance
        .collection('Recipe')
        .where('Recipe Category', isEqualTo: 'Salads')
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            docIDs.add(document.reference.id);
          }),
        );
  }
}
