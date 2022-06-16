import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class addRecipe extends StatefulWidget {
  const addRecipe({Key? key}) : super(key: key);

  @override
  State<addRecipe> createState() => _addRecipeState();
}

class _addRecipeState extends State<addRecipe> {
  final user = FirebaseAuth.instance.currentUser!;
  String imageName = '';
  XFile? imagePath;
  String imageURL = '';

  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  FirebaseStorage storageRef = FirebaseStorage.instance;
  String collectionName = 'images';

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
                Text("$imageName"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () {
                          imagePicker();
                        },
                        child: Icon(
                          Icons.camera_alt,
                          size: 30,
                          color: Colors.blue,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () {
                          imagePicker();
                        },
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
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
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
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
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
                  width: 60,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(213, 248, 28, 12),
                      elevation: 5,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    icon: const Icon(Icons.add, size: 32),
                    label: const Text(
                      'Add Recipe',
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: () {
                      _uploadImage();
                    }),
                const SizedBox(
                  height: 45,
                ),
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
    String refid = FirebaseFirestore.instance.collection('Recipe').doc().id;
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

  _uploadImage() async {
    var uniqueKey = firestoreRef.collection(collectionName).doc();
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    String uploadFileName =
        DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
    Reference reference =
        storageRef.ref().child(collectionName).child(uploadFileName);
    UploadTask uploadTask = reference.putFile(File(imagePath!.path));
    uploadTask.snapshotEvents.listen((event) {
      print(event.bytesTransferred.toString() +
          "\t" +
          event.totalBytes.toString());
    });

    await uploadTask.whenComplete(() async {
      var uploadPath = await uploadTask.snapshot.ref.getDownloadURL();
      if (uploadPath.isNotEmpty) {
        firestoreRef.collection("Recipe").doc(uniqueKey.id).set({
          'createdAt': FieldValue.serverTimestamp(),
          'Recipe Title': recipeTitleController.text,
          'Recipe Ingredients': recipeIngredientsController.text,
          'Recipe Description': recipeDescriptionController.text,
          'Recipe Category': recipeCategoryController.text,
          'Created By': uid,
          'Time to prepare': timeToPrepareController.text,
          'imageURl': uploadPath,
        }).then((value) => _showPrompt("Record Inserted"));
      } else {
        _showPrompt("Something While Uploading Went Wrong");
      }
    });
  }

  _showPrompt(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 3),
    ));
  }

  imagePicker() async {
    final XFile? image =
        await _pickerImage.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagePath = image;
        imageName = image.name.toString();
      });
    }
  }
}
