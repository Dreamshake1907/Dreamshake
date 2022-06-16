import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:food_recipe/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:food_recipe/page/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpWidget extends StatefulWidget {
  final VoidCallback onClickedSignIn;
  const SignUpWidget({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
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
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height / 25,
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 9),
                  height: height / 3,
                  width: width / 1.7,
                  child: Image.asset(
                    'lib/assets/Component 15.png',
                    fit: BoxFit.cover,
                  )),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Recipe Book",
                textAlign: TextAlign.center,
                style: GoogleFonts.carterOne(
                  color: Colors.red,
                  fontSize: 50,
                  fontWeight: FontWeight.w700,
                ),
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
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

/*checkUsernameIsUnique(String username)async
  {
    QuerySnapshot querySnapshot;
    setState(() {
      var loading=true;
    });
    querySnapshot=await FirebaseFirestore.instance.collection('username').where("username",isEqualTo: username).get();
    print(querySnapshot.docs.isNotEmpty);
    return querySnapshot.docs.isEmpty;
  }
*/

}
