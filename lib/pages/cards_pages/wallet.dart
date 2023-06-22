import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:ontime/models/credit_cards_models.dart/card_information.dart';
import 'package:ontime/pages/cards_pages/add_credit_card.dart';

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
      body: Stack(children: [
        const Positioned(
            top: 75,
            left: 20,
            child: Text(
              'My Wallet',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            )),
        Positioned(
          top: 100,
          left: 20,
          right: 20,
          child: Container(
            width: 500,
            height: 400,
            child: Card(
              child: FutureBuilder(
                  future: getCardData(getEmail()),
                  builder: (context, snapshot) {
                    if (snapshot.data == null || snapshot.data.isEmpty) {
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
                      return Expanded(
                          child: CarouselSlider(
                        items: List.generate(snapshot.data.length, (index) {
                          var cardNumber = snapshot.data[index].card_number;
                          var cardHolderName =
                              snapshot.data[index].card_holder_name;
                          var date = snapshot.data[index].date;
                          var cvv = snapshot.data[index].cvv;
                          return CreditCardWidget(
                            cardNumber: cardNumber,
                            cardBgColor: Colors.black,
                            expiryDate: date,
                            cardHolderName: cardHolderName,
                            cvvCode: cvv,
                            showBackView: false,
                            onCreditCardWidgetChange: (p0) {},
                          );
                        }),
                        options: CarouselOptions(
                          scrollDirection: Axis.vertical,
                          // Adjust the height as needed
                          enableInfiniteScroll:
                              false, // Set to true if you want infinite scrolling
                          viewportFraction:
                              0.8, // Adjust the fraction of the viewport occupied by each card
                        ),
                      ));
                    }
                  }),
            ),
          ),
        ),
        Positioned(
            bottom: 110,
            left: 10,
            right: 10,
            child: RawMaterialButton(
              fillColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AddCard()));
              },
              child: const Text(
                'Add New Card',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ))
      ]),
    );
  }
}
