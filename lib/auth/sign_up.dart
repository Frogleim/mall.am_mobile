import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ontime/auth/password_fields.dart';
import 'package:ontime/pages/home_page/bottom_nav_bar.dart';
import 'package:ontime/pages/home_page/home_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  void _registerUser() async {
    try {
      String email = _emailController.text.trim();
      String password = _phoneNumberController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        // Show error if email or password is empty
        return;
      }

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Registration success, do something with userCredential if needed
      print('Registration successful! User ID: ${userCredential.user?.uid}');
    } on FirebaseAuthException catch (e) {
      // Registration failed, handle the error
      print('Registration error: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 20),
              child: Text(
                'Sign Up',
                style: GoogleFonts.passionOne(
                    textStyle: const TextStyle(fontSize: 30)),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade400)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade400)),
                    filled: true,
                    hintStyle: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    hintText: "Email",
                    fillColor: Colors.transparent,
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.black,
                    )),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                keyboardType: TextInputType.phone,
                controller: _phoneNumberController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade400)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade400)),
                    filled: true,
                    hintStyle: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    hintText: "Phone Number",
                    fillColor: Colors.transparent,
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: Colors.black,
                    )),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            PasswordTextField(),
            const SizedBox(
              height: 30,
            ),
            RePasswordTextField(),
            ElevatedButton(
              onPressed: () {
                _registerUser();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Home()));
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
