import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ontime/pages/account_pages/address/check_address.dart';
import 'package:ontime/pages/cards_pages/check_wallet.dart';
import 'package:provider/provider.dart';

import '../../models/image_provider/image_provider.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String getEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    String userEmail = user?.email ?? '';
    return userEmail;
  }

  String imageUrl = ' ';

  void pickUploadImage(BuildContext context) async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );

    if (image != null) {
      Reference ref = FirebaseStorage.instance.ref().child("profile_image.jpg");
      try {
        await ref.putFile(File(image.path));
        String downloadURL = await ref.getDownloadURL();

        // Access the ImageProvider instance using Provider.of
        ImageProvide imageProvider =
            Provider.of<ImageProvide>(context, listen: false);
        imageProvider.imageUrl = downloadURL;

        print('Image uploaded successfully. Download URL: $downloadURL');
      } catch (e) {
        print('Failed to upload image: $e');
      }
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    ImageProvide imageProvider = Provider.of<ImageProvide>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            actions: [
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Icon(
                  Icons.logout,
                ),
              )
            ]),
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                width: 350,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: Colors.white, width: 0.5),
                    boxShadow: const [BoxShadow(blurRadius: 1.85)]),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        pickUploadImage(context);
                      },
                      child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20)),
                          child: imageProvider.imageUrl.isEmpty
                              ? const Icon(
                                  Icons.person,
                                  size: 40,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(22),
                                  child: Image.network(
                                    imageProvider.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Gor Barseghyan",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          getEmail(),
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[400]),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 300,
              width: 350,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 0.5),
                  borderRadius: BorderRadius.circular(22),
                  color: Colors.white,
                  boxShadow: const [BoxShadow(blurRadius: 1.85)]),
              child: Column(
                children: [
                  const SizedBox(
                    height: 36,
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Personal Information");
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(7)),
                          child: Icon(Icons.person),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          "Personal Information",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(
                          width: 45,
                        ),
                        const Icon(Icons.skip_next)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Wallet");
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CheckWallet()));
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(7)),
                          child: Icon(Icons.wallet_outlined),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          "My Wallet",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(
                          width: 138,
                        ),
                        const Icon(Icons.skip_next)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  GestureDetector(
                    onTap: () {
                      print("My Orders");
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(7)),
                          child: Icon(Icons.shopping_bag),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          "My Orders",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(
                          width: 135,
                        ),
                        const Icon(Icons.skip_next)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Wallet");
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(7)),
                          child: Icon(Icons.local_shipping),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const CheckAddress()));
                          },
                          child: const Text(
                            "Shipping Address",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          width: 77,
                        ),
                        const Icon(Icons.skip_next)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Wallet");
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(7)),
                          child: Icon(Icons.settings),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          "Settings",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(
                          width: 153,
                        ),
                        const Icon(Icons.skip_next)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
