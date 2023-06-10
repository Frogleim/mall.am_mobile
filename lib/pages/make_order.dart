import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ontime/model/add_to_cart.dart';
import 'package:ontime/model/check_cart.dart';
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
  int itemCount = 1;
  DateTime? selectedDate;
  TimeOfDay? selctedTime;

  String getEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    String userEmail = user?.email ?? '';
    return userEmail;
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
        body: Stack(
      children: [
        Positioned(
            top: 50,
            left: 20,
            child: Text(
              widget.productName as String,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            )),
        Positioned(
          top: 100,
          left: 20,
          right: 20,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black)),
            height: 460,
            width: 200,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(widget.productImage as String)),
          ),
        ),
        Positioned(
            right: 30,
            top: 570,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (itemCount > 1) {
                          itemCount--;
                        }
                      });
                    },
                    icon: Icon(Icons.remove)),
                Text(
                  itemCount.toString(),
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        itemCount++;
                      });
                    },
                    icon: Icon(Icons.add)),
                const SizedBox(
                  width: 20,
                ),
              ],
            )),
        Positioned(
            bottom: 100,
            left: 20,
            right: 20,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
              child: Text("Add to Cart "),
              onPressed: () {
                print("Buy");
                addtoCart();
                setState(() {
                  cartItemAdded = true;
                });
              },
            )),
        Positioned(
            bottom: 50,
            right: 20,
            child: CircleAvatar(
              backgroundColor: Colors.black,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Cart()));
                },
                child: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
              ),
            )),
        if (cartItemAdded || checkCart(getEmail() as String) != 'null')
          Positioned(
              bottom: 50,
              right: 18,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                    color: Colors.red, shape: BoxShape.circle),
              ))
      ],
    ));
  }
}
