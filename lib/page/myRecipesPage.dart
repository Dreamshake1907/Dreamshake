import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'RecipeListExpanded.dart';

class getMyRecipes extends StatefulWidget {
  const getMyRecipes({Key? key}) : super(key: key);

  @override
  State<getMyRecipes> createState() => _getMyRecipesState();
}

class _getMyRecipesState extends State<getMyRecipes> {
  List<String> docIDs = [];

  final user = FirebaseAuth.instance.currentUser!;
  final usermail = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'MY RECIPES',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '  Sign Out ${usermail}',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: IconButton(
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  icon: Icon(Icons.logout),
                ),
              )
            ],
          )),
          Expanded(
              child: FutureBuilder(
            future: getMyRecipes(),
            builder: (context, snapshot) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
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

  Future getMyRecipes() async {
    await FirebaseFirestore.instance
        .collection('Recipe')
        .where('Created By', isEqualTo: user.uid)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            docIDs.add(document.reference.id);
          }),
        );
  }
}
