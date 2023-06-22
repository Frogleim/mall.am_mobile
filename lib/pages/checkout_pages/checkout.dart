import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ontime/models/address_models/get_address.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String getEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    String userEmail = user?.email ?? '';
    return userEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                width: 400,
                child: FutureBuilder(
                  future: address(getEmail()),
                  builder: (context, snapshot) {
                    print('Data: ${snapshot.data}');
                    if (snapshot.data == null || snapshot.data.isEmpty) {
                      return const Center(
                        child: Text("Add your shipping address"),
                      );
                    } else {
                      return Container(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var street = snapshot.data[index].street;
                                var city = snapshot.data[index].city;
                                var zipcode = snapshot.data[index].zipcode;
                                var country = snapshot.data[index].country;
                                return Center(
                                    child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 60),
                                      child: Center(
                                        child: Container(
                                          width: 350,
                                          height: 150,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 0.5),
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                              color: Colors.white,
                                              boxShadow: const [
                                                BoxShadow(blurRadius: 1.85)
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: RichText(
                                                text: TextSpan(children: [
                                              const TextSpan(
                                                text: 'Street: ',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                  text: ' ${street}\n\n',
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 16)),
                                            ])),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
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
                                ));
                              },
                              itemCount: snapshot.data.length));
                    }
                  },
                ),
              ))
        ],
      ),
    );
  }
}
