import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ontime/model/card_information.dart';

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
    return Scaffold(
      body: Container(
          child: Card(
        child: FutureBuilder(
          future: getCardData(getEmail()),
          builder: (context, snapshot) {
            if (snapshot.hasData != null) {
              return Text('No card information ${snapshot.data}');
            } else {
              return Text('No data');
            }
          },
        ),
      )),
    );
  }
}
