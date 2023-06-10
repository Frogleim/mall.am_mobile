import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ontime/model/cart.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  String getEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    String userEmail = user?.email ?? '';
    return userEmail;
  }

  void getPrice() async {
    var email = getEmail();
    var data = cart(email);
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
              child: CircleAvatar(
                  child: Image.network(
                      'https://i.pinimg.com/564x/a7/da/a4/a7daa4792ad9e6dc5174069137f210df.jpg')),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: Stack(
          children: [
            const Positioned(
                top: 20,
                left: 20,
                child: Text(
                  'My Cart',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.5),
                )),
            Positioned.fill(
              top: 80,
              child: Card(
                child: FutureBuilder(
                  future: cart(getEmail()),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: Text("Your Cart is empty"),
                      );
                    } else {
                      return Expanded(
                          child: ListView.builder(
                              itemBuilder: (context, index) {
                                var product_name =
                                    snapshot.data[index].product_name;
                                var product_price =
                                    snapshot.data[index].product_price;
                                var product_image =
                                    snapshot.data[index].product_image;
                                return Center(
                                    child: Card(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(product_image),
                                        ),
                                        title: Text(
                                          product_name,
                                        ),
                                        subtitle: Text(
                                          product_price,
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
            ),
            const Positioned(
                bottom: 100,
                left: 20,
                child: Text(
                  'Total: ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 128, 128, 128)),
                )),
            const Positioned(
                bottom: 100,
                right: 20,
                child: Text(
                  '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                )),
            Positioned(
                bottom: 20,
                left: 10,
                right: 10,
                child: RawMaterialButton(
                  fillColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  onPressed: () {
                    print('Hello');
                    getPrice();
                  },
                  child: const Text(
                    'Proceed to Chekcout',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ))
          ],
        ));
  }
}
