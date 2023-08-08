import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:ontime/models/cart_models/remove_cart.dart';
import 'package:ontime/models/constants.dart';
import 'package:ontime/models/get_user_email.dart';
import 'package:ontime/models/image_provider/image_provider.dart';
import 'package:ontime/models/cart_models/cart.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final String userEmail = getEmail();
  double totalFinalPrice = 0.0;
  double finalPrice = 0;
  late int itemCount;
  List<int> counts = [];

  @override
  Widget build(BuildContext context) {
    ImageProvide imageProvider = Provider.of<ImageProvide>(context);
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
                          return Center(
                            child: Text("You cart is empty"),
                          );
                        } else {
                          return Container(
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var product_name =
                                        snapshot.data[index].product_name;
                                    var product_price =
                                        snapshot.data[index].product_price;
                                    var product_image =
                                        snapshot.data[index].product_image_url;
                                    var count = snapshot.data[index].count;
                                    var cartItem = snapshot.data[index];
                                    if (product_price.contains('\$')) {
                                      // Symbol found, remove it
                                      product_price =
                                          product_price.replaceAll('\$', '');
                                    }
                                    // print(product_price);
                                    finalPrice = double.parse(product_price);
                                    print(finalPrice);
                                    totalFinalPrice +=
                                        finalPrice; // Add the current product's final price to the total

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
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      if (count > 1) {
                                                        cartItem
                                                            .decrementCount();
                                                      }
                                                      print(count);
                                                    });
                                                  },
                                                  icon:
                                                      const Icon(Icons.remove)),
                                              Text(cartItem.count.toString()),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      cartItem.incrementCount();
                                                    });
                                                  },
                                                  icon: const Icon(Icons.add)),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  print('Trash');
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
                left: 20,
                right: 20,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 260),
                      child: Text(
                        'Total: ${totalFinalPrice}',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 128, 128, 128)),
                      ),
                    ),
                    const Positioned(
                        bottom: 100,
                        right: 20,
                        child: Text(
                          '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 23),
                        )),
                    RawMaterialButton(
                      fillColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 100),
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
                          removeToCart(userEmail);
                          await Future.delayed(Duration(milliseconds: 500));
                          setState(() {});
                        });
                      },
                      child: const Text(
                        'Proceed to Checkout',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    )
                  ]),
                )),
          ],
        ));
  }
}
