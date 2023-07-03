import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Lottie.network(
                'https://assets1.lottiefiles.com/packages/lf20_teutzxdt.json',
                height: 300,
                width: 500),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Text(
              'Page not Found',
              style: GoogleFonts.passionOne(textStyle: TextStyle(fontSize: 30)),
            ),
          )
        ],
      ),
    );
  }
}
