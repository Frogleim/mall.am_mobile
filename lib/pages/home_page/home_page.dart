import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:ontime/models/image_provider/image_provider.dart';
import 'package:ontime/pages/products/check_shop.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isStarred = false;
  bool isStarred_1 = false;
  List<dynamic> data = [];
  String getEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    String userEmail = user?.email ?? '';
    return userEmail;
  }

  Future<void> fetchBrands() async {
    final response = await http.get(Uri.parse('http://172.21.96.1/brands/'));

    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
        print(data);
      });
    } else {
      print('Failed to fetch');
    }
  }

  void toggleFavorite() {
    setState(() {
      isStarred = true;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchBrands();
  }

  @override
  Widget build(BuildContext context) {
    ImageProvide imageProvider = Provider.of<ImageProvide>(context);

    return Scaffold(
        body: Stack(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 50, left: 15),
            child: Text(
              'Brands',
              style: GoogleFonts.passionOne(textStyle: TextStyle(fontSize: 33)),
            )),
        Divider(),
        Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Card(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Column(children: [
                            GestureDetector(
                              onTap: () {
                                print(data[index]['name']);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CheckShop(
                                        shop_name: data[index]['name'])));
                              },
                              child: Container(
                                width: 180,
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      width: 2,
                                      color: const Color.fromARGB(
                                          255, 185, 184, 184),
                                    )),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(data[index]['logo']),
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),
                    );
                  })),
        )
      ],
    ));
  }
}
