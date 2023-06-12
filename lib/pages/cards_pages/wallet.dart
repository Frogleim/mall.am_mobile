import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ontime/model/card_information.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  String getEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    String userEmail = user?.email ?? '';
    return userEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        const SizedBox(
          height: 150,
        ),
        CreditCardWidget(
          cardHolderName: '',
          expiryDate: '',
          cardNumber: '',
          cvvCode: '',
          onCreditCardWidgetChange: (p0) {},
          showBackView: false,
          cardBgColor: Colors.black,
          obscureCardCvv: true,
        ),
        const SizedBox(height: 70),
        Center(
            child: GestureDetector(
          onTap: () {
            print('add card');
          },
          child: const CircleAvatar(
            backgroundColor: Colors.black,
            radius: 40,
            child: Icon(
              Icons.add,
              size: 35,
              color: Colors.white,
            ),
          ),
        ))
      ]),
    );
  }
}
