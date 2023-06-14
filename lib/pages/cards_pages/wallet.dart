import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ontime/pages/cards_pages/add_credit_card.dart';

import '../../model/card_information.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _AddCardState();
}

class _AddCardState extends State<Wallet> {
  String getEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    String userEmail = user?.email ?? '';
    return userEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Stack(children: [
          const SizedBox(
            height: 140,
          ),
          Card(
            borderOnForeground: false,
            semanticContainer: false,
            child: FutureBuilder(
                future: getCardData(getEmail()),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data.isEmpty) {
                    print(snapshot.data);

                    return Column(children: [
                      const SizedBox(
                        width: 320,
                        child: Text(
                          "Wallet",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                      Lottie.network(
                        "https://assets6.lottiefiles.com/private_files/lf30_4b8xfsqj.json",
                        repeat: false,
                      ),
                      Center(
                          child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const AddCard()));
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
                    ]);
                  } else {
                    return Container(
                        child: ListView.builder(itemBuilder: (context, index) {
                      var cardNumber = snapshot.data[index].cvv;
                      var cardHolderNmae = snapshot.data[index].date;
                      var date = snapshot.data[index].card_holder_name;
                    }));
                  }
                }),
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}
