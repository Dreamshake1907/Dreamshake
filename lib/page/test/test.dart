// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'HomePage.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

// class favPage extends StatefulWidget {
//   const favPage({Key? key}) : super(key: key);

//   @override
//   State<favPage> createState() => _favPageState();
// }

// class _favPageState extends State<favPage> {
//   final user = FirebaseAuth.instance.currentUser!;

//   final recipeTitleController = TextEditingController();
//   final recipeDescripController = TextEditingController();
//   final recipeIngredientsController = TextEditingController();
//   final recipeKitchenController = TextEditingController();

//   @override
//   void dispose() {
//     recipeTitleController.dispose();
//     recipeDescripController.dispose();
//     recipeIngredientsController.dispose();
//     recipeKitchenController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(30),
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           SizedBox(
//             height: 10,
//           ),
//           TextFormField(
//             controller: recipeTitleController,
//             cursorColor: Colors.white,
//             textInputAction: TextInputAction.next,
//             decoration: const InputDecoration(
//               labelText: "Recipe Title",
//               prefixIcon: Icon(Icons.mail),
//             ),
//           ),
//           const SizedBox(
//             height: 4,
//           ),
//           TextFormField(
//             controller: recipeIngredientsController,
//             cursorColor: Colors.white,
//             textInputAction: TextInputAction.next,
//             decoration: const InputDecoration(
//               labelText: "Recipe ıngredit",
//               prefixIcon: Icon(Icons.mail),
//             ),
//           ),
//           const SizedBox(
//             height: 4,
//           ),
//           TextFormField(
//             controller: recipeDescripController,
//             cursorColor: Colors.white,
//             textInputAction: TextInputAction.next,
//             decoration: const InputDecoration(
//               labelText: "Recipe Descrip",
//               prefixIcon: Icon(Icons.mail),
//             ),
//           ),
//           const SizedBox(
//             height: 4,
//           ),
//           TextFormField(
//             controller: recipeKitchenController,
//             cursorColor: Colors.white,
//             textInputAction: TextInputAction.next,
//             decoration: const InputDecoration(
//               labelText: "Recipe Kitchen",
//               prefixIcon: Icon(Icons.mail),
//             ),
//           ),
//           const SizedBox(
//             height: 4,
//           ),
//           ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 primary: Color.fromARGB(213, 248, 28, 12),
//                 elevation: 5,
//                 minimumSize: const Size.fromHeight(50),
//               ),
//               icon: const Icon(Icons.lock_open, size: 32),
//               label: const Text(
//                 'Sign Up',
//                 style: TextStyle(fontSize: 24),
//               ),
//               onPressed: Recipeadder),
//           const Text(
//             "Signed In As:",
//             style: TextStyle(fontSize: 20, color: Colors.black),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             user.email!,
//             style: const TextStyle(fontSize: 24, color: Colors.black),
//           ),
//           const SizedBox(
//             height: 45,
//           ),
//           ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size.fromHeight(50),
//               ),
//               icon: const Icon(
//                 Icons.arrow_back,
//                 size: 34,
//               ),
//               label: const Text('Sign Out',
//                   style: TextStyle(color: Colors.white, fontSize: 30)),
//               onPressed: () => FirebaseAuth.instance.signOut()),
//         ]),
//       ),
//     );
//   }

//   Future Recipeadder() async {
//     addRecipeData(
//       recipeTitleController.text.trim(),
//       recipeIngredientsController.text.trim(),
//       recipeDescripController.text.trim(),
//       recipeKitchenController.text.trim(),
//     );
//   }

// ignore_for_file: camel_case_types, prefer_const_constructors, unnecessary_new

//   Future addRecipeData(
//     String recipeTitle,
//     String recipeIngredients,
//     String recipeDescrip,
//     String recipeKitchen,
//   ) async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     String uid = auth.currentUser!.uid.toString();
//     await FirebaseFirestore.instance.collection('Recipe').add({
//       'Recipe Title': recipeTitle,
//       'Recipe Ingredit': recipeIngredients,
//       'Recipe Descrip': recipeDescrip,
//       'Recipe Kitchen': recipeKitchen,
//       'Created By': uid,
//     });
//   }
// }
import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class faPage extends StatefulWidget {
  const faPage({Key? key}) : super(key: key);

  @override
  State<faPage> createState() => _faPageState();
}

class _faPageState extends State<faPage> {
  final user = FirebaseAuth.instance.currentUser!;
  late File image;
  String imageURL = '';
  final recipeTitleController = TextEditingController();
  final recipeDescriptionController = TextEditingController();
  final recipeIngredientsController = TextEditingController();
  final recipeCategoryController = TextEditingController();
  final timeToPrepareController = TextEditingController();

  @override
  void dispose() {
    recipeTitleController.dispose();
    recipeDescriptionController.dispose();
    recipeIngredientsController.dispose();
    recipeCategoryController.dispose();
    timeToPrepareController.dispose();
    super.dispose();
  }

  final ImagePicker _pickerImage = ImagePicker();
  dynamic _pickImage;
  var profileImage;
  String url = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   color: Colors.yellow,
                //   height: 200,
                //   width: double.infinity,
                //   child: Text("Image"),
                // ),
                Center(
                  child: imagePlace(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () => _onImageButtonPressed(ImageSource.camera,
                            context: context),
                        child: Icon(
                          Icons.camera_alt,
                          size: 30,
                          color: Colors.blue,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () => _onImageButtonPressed(ImageSource.gallery,
                            context: context),
                        child: Icon(
                          Icons.image,
                          size: 30,
                          color: Colors.blue,
                        ))
                  ],
                ),

                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: recipeTitleController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: new OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 224, 91, 91)),
                    ),
                    //  labelStyle: TextStyle(color: Color.fromARGB(255, 23, 5, 24)),
                    labelText: "Recipe Title",
                    hintText: "Enter Recipe's Title",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: recipeCategoryController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: new OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 224, 91, 91)),
                    ),
                    // labelStyle: TextStyle(color: Color.fromARGB(255, 23, 5, 24)),
                    labelText: "Recipe Category",
                    hintText: "Enter Recipe's Category",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: timeToPrepareController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: new OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 224, 91, 91)),
                    ),
                    // labelStyle: TextStyle(color: Color.fromARGB(255, 23, 5, 24)),
                    labelText: "Recipe Duration",
                    hintText: "Enter Recipe's Time to Prepare",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: recipeIngredientsController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: new OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 224, 91, 91)),
                    ),
                    // labelStyle: TextStyle(color: Color.fromARGB(255, 23, 5, 24)),
                    labelText: "Recipe Ingredients",
                    hintText: "Enter Recipe's Ingredients",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                TextFormField(
                  controller: recipeDescriptionController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: new OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 224, 91, 91)),
                    ),
                    // labelStyle: TextStyle(color: Color.fromARGB(255, 23, 5, 24)),
                    labelText: "Recipe Description",
                    hintText: "Enter Recipe's Description",
                  ),
                ),

                const SizedBox(
                  height: 45,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(213, 248, 28, 12),
                      elevation: 5,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    icon: const Icon(Icons.lock_open, size: 32),
                    label: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: Recipeadder),
                // const Text(
                //   "Signed In As:",
                //   style: TextStyle(fontSize: 20, color: Colors.black),
                // ),
                // const SizedBox(height: 10),
                // Text(
                //   user.email!,
                //   style: const TextStyle(fontSize: 24, color: Colors.black),
                // ),
                const SizedBox(
                  height: 45,
                ),
                // ElevatedButton.icon(
                //     style: ElevatedButton.styleFrom(
                //       minimumSize: const Size.fromHeight(50),
                //     ),
                //     icon: const Icon(
                //       Icons.arrow_back,
                //       size: 34,
                //     ),
                //     label: const Text('Sign Out',
                //         style: TextStyle(color: Colors.white, fontSize: 30)),
                //     onPressed: () => FirebaseAuth.instance.signOut()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onImageButtonPressed(ImageSource source,
      {required BuildContext context}) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      String uid = auth.currentUser!.uid.toString();
      final pickedFile = await _pickerImage.pickImage(source: source);
      setState(() {
        profileImage = pickedFile!;
        print("Image recieved: $profileImage");
        if (profileImage != null) {}
      });
      print('aaa');
      final ref = FirebaseStorage.instance.ref().child("RecipeImages");
      // .child(uid + '.jpg');
      await ref.putFile(profileImage);
      url = await ref.getDownloadURL();
      print(url);
    } catch (e) {
      setState(() {
        _pickImage = e;
        print("Image Error: " + _pickImage);
      });
    }
  }

  Widget imagePlace() {
    double height = MediaQuery.of(context).size.height;
    if (profileImage != null) {
      return CircleAvatar(
          backgroundImage: FileImage(File(profileImage!.path)),
          radius: height * 0.08);
    } else {
      if (_pickImage != null) {
        return Container(
          width: 200,
          height: 200,
          child: Image.network(
            _pickImage,
            fit: BoxFit.cover,
            width: 200,
            height: 200,
          ),
        );
      } else {
        return CircleAvatar(
          backgroundImage: AssetImage("assets/Component.png"),
          radius: height * 0.08,
        );
      }
    }
  }

  Future Recipeadder() async {
    addRecipeData(
      timeToPrepareController.text.trim(),
      recipeTitleController.text.trim(),
      recipeIngredientsController.text.trim(),
      recipeDescriptionController.text.trim(),
      recipeCategoryController.text.trim(),
    );
  }

  Future addRecipeData(
    String recipeTitle,
    String timeToPrepare,
    String recipeIngredients,
    String recipeDescription,
    String recipeCategory,
  ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    await FirebaseFirestore.instance.collection('Recipe').add({
      'Recipe Title': recipeTitle,
      'Recipe Ingredients': recipeIngredients,
      'Recipe Description': recipeDescription,
      'Recipe Category': recipeCategory,
      'Created By': uid,
      'Time to prepare': timeToPrepare,
      'ImageURL': url,
    });
  }
}
