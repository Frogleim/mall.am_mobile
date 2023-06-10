import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ontime/pages/cart.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.black, actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: const Icon(
              Icons.logout,
            ),
          )
        ]),
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 100,
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 30, top: 0),
                child: const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      'https://i.pinimg.com/564x/a7/da/a4/a7daa4792ad9e6dc5174069137f210df.jpg'),
                )),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              // width: 100,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              child: Text("My info"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Cart()));
              },
              child: Container(
                height: 80,
                // width: 100,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white),
                child: const Text("My Cart"),
              ),
            )
          ]),
        ));
  }
}
