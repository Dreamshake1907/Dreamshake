import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:food_recipe/main.dart';
import 'package:food_recipe/page/forgot_password.dart';
import 'package:food_recipe/page/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginWidget({
    Key? key,
    required this.showRegisterPage,
  }) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passswordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      reverse: true,
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: height / 25,
          ),
          Container(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 9),
                  height: height / 3,
                  width: width / 1.7,
                  child: Image.asset(
                    'lib/assets/Component 15.png',
                    fit: BoxFit.cover,
                  ))),
          SizedBox(
            height: 10,
          ),
          Text(
            'RECIPE BOOK',
            style: GoogleFonts.carterOne(
              color: Color.fromARGB(213, 248, 28, 12),
              fontSize: 40,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.mail),
              )),
          const SizedBox(
            height: 5,
          ),
          TextField(
            controller: passswordController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              labelText: "Password",
              prefixIcon: Icon(Icons.password_sharp),
            ),
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
              'Sign In',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: signIn,
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            child: const Text(
              'Forgot Password ?',
              style: TextStyle(
                  fontSize: 16, color: Color.fromARGB(255, 138, 138, 138)),
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const forgotPasswordPage())),
          ),
          const SizedBox(
            height: 10,
          ),
          RichText(
              text: TextSpan(
            style: const TextStyle(
                color: Color.fromARGB(255, 240, 16, 16), fontSize: 24),
            text: 'No Account ?  ',
            children: [
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = widget.showRegisterPage,
                text: 'Sign Up',
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Color.fromARGB(255, 53, 53, 53)),
              ),
            ],
          ))
        ],
      ),
    );
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passswordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
