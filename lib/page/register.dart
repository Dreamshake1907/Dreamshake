import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:food_recipe/main.dart';
import 'package:food_recipe/page/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase.dart';

class registerPage extends StatefulWidget {
  final VoidCallback onClickedSignIn;
  const registerPage({Key? key, required this.onClickedSignIn})
      : super(key: key);

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _userNameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
        reverse: true,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "Hello There",
                textAlign: TextAlign.center,
                style: GoogleFonts.carterOne(
                  color: Colors.red,
                  fontSize: 50,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "Register below",
                textAlign: TextAlign.center,
                style: GoogleFonts.carterOne(
                  color: Colors.red,
                  fontSize: 50,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                controller: _firstNameController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: "First Name",
                  prefixIcon: Icon(Icons.mail),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                controller: _lastNameController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: "Last Name",
                  prefixIcon: Icon(Icons.mail),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                controller: _userNameController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: "Username",
                  prefixIcon: Icon(Icons.mail),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.mail),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email'
                        : null,
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                controller: passswordController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.password_rounded),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? 'Enter min 6 characters'
                    : null,
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
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
                onPressed: signUp,
              ),
              const SizedBox(
                height: 24,
              ),
              RichText(
                  text: TextSpan(
                style: const TextStyle(
                    color: Color.fromARGB(255, 240, 16, 16), fontSize: 20),
                text: 'Already have an account ?  ',
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSignIn,
                    text: 'Log In ',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color.fromARGB(255, 53, 53, 53)),
                  ),
                ],
              ))
            ],
          ),
        ));
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passswordController.text.trim(),
      );
      addUserData(
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
        emailController.text.trim(),
        _userNameController.text.trim(),
      );
      userSetup(_userNameController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future addUserData(
      String firstName, String lastName, String email, String userName) async {
    await FirebaseFirestore.instance.collection('users').add({
      'First  Name': firstName,
      'Last Name': lastName,
      'Email': email,
      'UserName': userName,
    });
  }
}
