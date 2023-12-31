import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:ontime/models/cart_models/add_to_cart.dart';
import 'package:ontime/models/cart_models/count_handler.dart';
import 'package:ontime/pages/cart/cart.dart';

class MakeOrder extends StatefulWidget {
  final String productName;
  final String productImage;
  final String productPrice;
  final String description;
  final String product_image_url;
  const MakeOrder({
    super.key,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.description,
    required this.product_image_url,
  });

  @override
  State<MakeOrder> createState() => _MakeOrderState();
}

class _MakeOrderState extends State<MakeOrder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  bool cartItemAdded = false;
  bool isLiked = false;
  int itemCount = 1;
  DateTime? selectedDate;
  TimeOfDay? selctedTime;

  String getEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    String userEmail = user?.email ?? '';
    return userEmail;
  }

  void toggleFavorite() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> addtoCart() async {
    showDialog(
      context: context,
      barrierDismissible:
          true, // Prevent dismissing the dialog by tapping outside
      builder: (context) {
        return AlertDialog(
          title: Lottie.network(
              'https://lottie.host/f2ef9b84-6098-4283-99c5-0f175d658fa2/5R9QDsNLdC.json'),
        );
      },
    );

    try {
      var totalPrice = double.parse(widget.productPrice) * itemCount;
      print(totalPrice);
      await addToCart(
        getEmail(),
        widget.productName,
        'mall',
        itemCount,
        widget.productImage,
        widget.productPrice,
        totalPrice.toString(),
      );
      // Close the loading dialog after addToCart is completed
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Something went wrong!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the error dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Cart()));
              },
              child: const Icon(Icons.shopping_basket_outlined),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: Stack(
          children: [
            Positioned(
              top: 10,
              left: 0,
              right: 0,
              child: Container(
                height: 400,
                width: 200,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(widget.productImage as String)),
              ),
            ),
            Positioned(
                top: 440,
                left: 20,
                child: Text(
                  widget.productName.replaceAllMapped(
                      RegExp(r"(\S+\s+){3}"), (match) => '${match.group(0)}\n'),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                )),
            Positioned(
                right: 30,
                top: 540,
                child: Container(
                  height: 35,
                  width: 117,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromARGB(255, 209, 209, 209)),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 12,
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (itemCount > 1) {
                                itemCount--;
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.remove,
                            size: 15,
                          )),
                      Text(
                        itemCount.toString(),
                        style: TextStyle(fontSize: 15),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              itemCount++;
                            });
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 15,
                          )),
                    ],
                  ),
                )),
            Positioned(
                top: 540,
                left: 10,
                child: RatingBar.builder(
                    initialRating: 1,
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                    itemSize: 25,
                    itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    })),
            Positioned(
                bottom: 50,
                right: 20,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      fixedSize: MaterialStateProperty.all(Size(180, 50)),
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  child: const Text(
                    "Add to Cart",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.5),
                  ),
                  onPressed: () {
                    print("Buy");
                    addtoCart();
                    setState(() {
                      cartItemAdded = true;
                    });
                  },
                )),
            const Positioned(
                bottom: 90,
                left: 20,
                child: Text(
                  'Total Price',
                  style: TextStyle(color: Colors.grey),
                )),
            Positioned(
                bottom: 50,
                left: 20,
                child: Text(
                  widget.productPrice,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30),
                )),
            Positioned(
                bottom: 200,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    if (isLiked == false) {
                      isLiked == true;
                      _controller.forward();
                    } else {
                      isLiked == false;
                      _controller.reverse();
                    }
                  },
                  child: Lottie.network(
                      "https://assets4.lottiefiles.com/packages/lf20_lwojhyyk.json",
                      controller: _controller,
                      width: 80,
                      height: 80),
                ))
          ],
        ));
  }
}
