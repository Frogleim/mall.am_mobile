import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:ontime/models/constants.dart';
import 'package:ontime/models/get_user_email.dart';
import 'package:ontime/models/image_provider/image_provider.dart';
import 'package:ontime/models/cart_models/cart.dart';
import 'package:ontime/pages/checkout_pages/checkout.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final String userEmail = getEmail();
  double finalPrice = 0;

  @override
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
                        if (snapshot.data == null || snapshot.data.isEmpty) {
                          return Center(
                            child: Lottie.network(
                                'https://assets9.lottiefiles.com/packages/lf20_kxsd2ytq.json'),
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
                                        snapshot.data[index].product_image;
                                    if (product_price.contains('\$')) {
                                      // Symbol found, remove it
                                      product_price =
                                          product_price.replaceAll('\$', '');
                                    }
                                    double doublePrices =
                                        double.parse(product_price);
                                    doublePrices += doublePrices;
                                    finalPrice = doublePrices;
                                    print(finalPrice);
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
                      padding: EdgeInsets.only(right: 260),
                      child: Text(
                        'Total: ${finalPrice}',
                        style: TextStyle(
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
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: deliverySuccess,
                                content: Text(
                                  'Your order approved!',
                                  style: TextStyle(fontSize: 20),
                                ),
                              );
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
