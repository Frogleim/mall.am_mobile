import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ontime/model/add_to_cart.dart';
import 'package:ontime/pages/cart.dart';

class MakeOrder extends StatefulWidget {
  final String productName;
  final String productImage;
  final String productPrice;
  final String description;
  final String product_image_url;
  const MakeOrder(
      {super.key,
      required this.productName,
      required this.productImage,
      required this.productPrice,
      required this.description,
      required this.product_image_url});

  @override
  State<MakeOrder> createState() => _MakeOrderState();
}

class _MakeOrderState extends State<MakeOrder> {
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

  Future<void> addtoCart() async {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent dismissing the dialog by tapping outside
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        );
      },
    );

    try {
      await addToCart(getEmail(), widget.productName, widget.productPrice,
          widget.productImage, itemCount.toString());
      Navigator.pop(
          context); // Close the loading dialog after addToCart is completed
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
                  '\$${widget.productPrice}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30),
                )),
            Positioned(
                bottom: 230,
                right: 20,
                child: InkWell(
                  onTap: toggleFavorite,
                  splashColor: Colors.red,
                  highlightColor: Colors.transparent,
                  child: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.black,
                    size: 28,
                  ),
                ))
          ],
        ));
  }
}
