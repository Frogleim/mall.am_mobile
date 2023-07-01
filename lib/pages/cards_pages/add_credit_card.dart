import 'package:flutter/material.dart';

class AddCreditCard extends StatefulWidget {
  const AddCreditCard({super.key});

  @override
  State<AddCreditCard> createState() => _AddCreditCardState();
}

class _AddCreditCardState extends State<AddCreditCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Text(
          "Wallet",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ]),
    );
  }
}
