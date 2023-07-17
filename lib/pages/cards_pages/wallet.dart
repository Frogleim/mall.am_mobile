import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:ontime/models/credit_cards_models.dart/card_information.dart';
import 'package:ontime/models/get_user_email.dart';
import 'package:ontime/pages/cards_pages/fill_card_info.dart';
import 'package:http/http.dart' as http;

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _AddCardState();
}

class _AddCardState extends State<Wallet> {
  late final userEmail = getEmail();
  List<CardInformation> cardData = [];
  Future getCards(String userEmail) async {
    var response = await http.get(
        Uri.parse("http://172.27.144.1/get_card_information/${userEmail}"));
    var json = jsonDecode(response.body);
    for (var items in json) {
      final card = CardInformation(
          customer_email: items['customer_email'],
          card_holder_name: items['card_holder_name'],
          card_number: items['card_number'],
          date: items['date'],
          cvv: items['cvv']);
      cardData.add(card);
    }

    print(cardData.length);
    return cardData;
  }

  @override
  Widget build(BuildContext context) {
    getCards(userEmail);
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
                  future: getCards(userEmail),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.data);

                      return Column(children: [
                        const SizedBox(
                          width: 320,
                          child: Text(
                            "Error",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ),
                        Lottie.network(
                          "https://assets10.lottiefiles.com/packages/lf20_0pgmwzt3.json",
                          repeat: false,
                        ),
                      ]);
                    } else {
                      return Expanded(
                          child: CarouselSlider(
                        items:
                            List.generate(snapshot.data?.length ?? 0, (index) {
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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FillCardInfo()));
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
