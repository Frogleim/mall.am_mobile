import 'package:flutter/material.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:ontime/models/address_models/get_address.dart';
import 'package:ontime/models/cart_models/count_handler.dart';
import 'package:ontime/models/cart_models/remove_cart.dart';
import 'package:ontime/models/constants.dart';
import 'package:ontime/models/get_user_email.dart';
import 'package:ontime/models/cart_models/cart.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final String userEmail = getEmail();
  late int itemCount;
  List<int> counts = [];
  bool isCheckedCreditCard = false;
  bool isCheckedCash = false;
  bool isCheckedLoan = false;
  var _totalPrice;

  void removeFromCart(String email, String product_name) {
    setState(() {
      removeToCart(email, product_name);
    });
  }

  @override
  void initState() {
    super.initState();
    // Call the totalPrice function in initState
    totalPrice(userEmail);
  }

  Future<void> totalPrice(String userEmail) async {
    final url = Uri.parse('http://172.21.96.1/total_price/$userEmail');

    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.get(url, headers: headers);
    var jsonData = jsonDecode(response.body);

    setState(() {
      _totalPrice = jsonData.toString(); // Update the _totalPrice state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Stack(
          children: [
            Positioned(
                top: 20,
                left: 20,
                child: Text(
                  'My Cart',
                  style: GoogleFonts.passionOne(
                      textStyle: TextStyle(fontSize: 30)),
                )),
            Positioned(
                top: 50,
                child: SizedBox(
                  height: 450,
                  width: 400,
                  child: Card(
                    child: FutureBuilder(
                      future: cart(userEmail),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Lottie.network(
                                'https://assets9.lottiefiles.com/packages/lf20_kxsd2ytq.json'),
                          );
                        } else if (snapshot.data == null ||
                            snapshot.data.isEmpty) {
                          print(snapshot.data);
                          return const Center(
                            child: Text("You cart is empty"),
                          );
                        } else {
                          return Container(
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var product_name =
                                        snapshot.data[index].productName;
                                    var product_price =
                                        snapshot.data[index].productPrice;
                                    var product_image =
                                        snapshot.data[index].productImage;
                                    print(product_image);
                                    var count = snapshot.data[index].count;
                                    var totalPrice =
                                        snapshot.data[index].productTotalPrice;
                                    var cartItem = snapshot.data[index];

                                    return Center(
                                        child: Card(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            leading: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child:
                                                  Image.network(product_image),
                                            ),
                                            title: Text(
                                              product_name,
                                            ),
                                            subtitle: Text(
                                              '\$${product_price}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                  'X${cartItem.count.toString()}'),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  print('Trash');
                                                  removeFromCart(
                                                      userEmail, product_name);
                                                },
                                                child: Icon(Icons.delete),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ));
                                  },
                                  itemCount: snapshot.data.length));
                        }
                      },
                    ),
                  ),
                )),
            Positioned(
                bottom: 80,
                left: 10,
                right: 10,
                child: SlidingBox(
                  body: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          'CheckOut',
                          style: GoogleFonts.passionOne(
                              textStyle: const TextStyle(fontSize: 20)),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Column(
                        children: [
                          Card(),
                          const SizedBox(
                            width: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                const Icon(Icons.credit_card),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text('Pay with Credit card'),
                                const SizedBox(
                                  width: 113,
                                ),
                                Checkbox(
                                    activeColor: Colors.black,
                                    checkColor: Colors.white,
                                    value: isCheckedCreditCard,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isCheckedCreditCard = value!;
                                      });
                                    })
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                const Icon(Icons.attach_money),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text('Pay with Cash'),
                                const SizedBox(
                                  width: 150,
                                ),
                                Checkbox(
                                    activeColor: Colors.black,
                                    checkColor: Colors.white,
                                    value: isCheckedCash,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isCheckedCash = value!;
                                      });
                                    })
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                const Icon(Icons.watch_later_outlined),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text('Pay with Loan'),
                                const SizedBox(
                                  width: 150,
                                ),
                                Checkbox(
                                    activeColor: Colors.black,
                                    checkColor: Colors.white,
                                    value: isCheckedLoan,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isCheckedLoan = value!;
                                      });
                                    }),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          RawMaterialButton(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 140),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: deliverySuccess,
                                      content: const Text(
                                        'Your order approved!',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    );
                                  }).then((value) async {
                                await Future.delayed(
                                    Duration(milliseconds: 500));
                                setState(() {
                                  removeAllCart(userEmail);
                                });
                              });
                            },
                            fillColor: Colors.black,
                            child: Text(
                              'Pay $_totalPrice',
                              style: GoogleFonts.passionOne(
                                  textStyle: const TextStyle(
                                      color: Colors.white, fontSize: 23)),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  minHeight: 60,
                )),
          ],
        ));
  }
}
