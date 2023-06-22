import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ontime/image_provider.dart';
import 'package:ontime/pages/account_pages/account.dart';
import 'package:ontime/pages/products/coffee_house.dart';
import 'package:ontime/pages/products/eshop_category.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isStarred = false;
  bool isStarred_1 = false;
  String getEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    String userEmail = user?.email ?? '';
    return userEmail;
  }

  void toggleFavorite() {
    setState(() {
      isStarred = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    ImageProvide imageProvider = Provider.of<ImageProvide>(context);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: GestureDetector(
            onTap: () {
              // FirebaseAuth.instance.signOut();
              print(imageProvider.imageUrl);
            },
            child: Icon(Icons.logout),
          ),
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Account()));
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  backgroundImage: NetworkImage(
                    imageProvider.imageUrl,
                  ),
                )),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: Stack(
          children: [
            const Positioned(
                top: 100,
                left: 20,
                child: Text(
                  "Brands",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                )),
            Positioned(
                top: 150,
                left: 20,
                right: 20,
                child: Stack(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Coffee()));
                        },
                        child: Container(
                          width: 400,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2.0),
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              'https://i.pinimg.com/564x/11/fd/4f/11fd4fec4bb73609036bd6e54311f74c.jpg', // Replace with the path to your image asset
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                  ],
                )),
            Positioned(
                top: 400,
                left: 20,
                right: 20,
                child: Stack(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ShopCategory()));
                        },
                        child: Container(
                          width: 400,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2.0),
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              'https://i.pinimg.com/564x/08/bd/69/08bd692665c8ddd52337528a8f88a919.jpg', // Replace with the path to your image asset
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                  ],
                )),
          ],
        ));
  }
}
