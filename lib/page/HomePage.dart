import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'categoryPage.dart';
import 'myRecipesPage.dart';
import 'addRecipe.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 1;

  final screens = [
    getMyRecipes(),
    catPage(),
    addRecipe(),
  ];

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              indicatorColor: Colors.red.shade100,
              labelTextStyle: MaterialStateProperty.all(
                TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 97, 97, 97)),
              )),
          child: NavigationBar(
              height: 60,
              backgroundColor: Color.fromARGB(255, 236, 236, 236),
              selectedIndex: index,
              onDestinationSelected: (index) =>
                  setState(() => this.index = index),
              destinations: [
                NavigationDestination(
                    icon: Icon(Icons.note_add,
                        color: Color.fromARGB(255, 143, 143, 143)),
                    label: 'MyRecipes'),
                NavigationDestination(
                    icon: Icon(Icons.home,
                        color: Color.fromARGB(255, 143, 143, 143)),
                    label: 'Home'),
                NavigationDestination(
                    icon: Icon(Icons.add_photo_alternate_outlined,
                        color: Color.fromARGB(255, 143, 143, 143)),
                    label: 'Add Recipe'),
              ])),
    );
  }
}
