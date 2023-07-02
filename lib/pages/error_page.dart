import 'package:flutter/material.dart';
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
      body: Center(
        child: Lottie.network(
            'https://assets1.lottiefiles.com/packages/lf20_teutzxdt.json'),
      ),
    );
  }
}
