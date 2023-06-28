import 'package:flutter/material.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  bool narek_pidor = false;
  int age = 20;
  String name = 'Narek';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 100, left: 50),
          child: GestureDetector(
            onTap: () {
              print('Clicked');
            },
            child: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
        ));
  }
}
