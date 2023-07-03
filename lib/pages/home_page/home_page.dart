import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:ontime/models/brands.dart';
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
  late Future<List<Brand>> _brandsFuture;
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
  void initState() {
    super.initState();
    _brandsFuture = getBrands();
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
              child: FutureBuilder(
            future: _brandsFuture,
            builder: (context, snapshot) {
              if (snapshot.data == null || snapshot.hasError) {
                print(snapshot.error);
                return Center(
                    child: Lottie.network(
                        'https://assets9.lottiefiles.com/packages/lf20_kxsd2ytq.json'));
              } else {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 176),
                  itemBuilder: (context, index) {
                    var brand_name = snapshot.data![index].brand_name;
                    var brand_photo = snapshot.data![index].brand_photo;
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () {},
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    print(brand_name);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => CheckShop(
                                                shop_name: brand_name)));
                                  },
                                  child: Container(
                                    width: 180,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            width: 2,
                                            color: const Color.fromARGB(
                                                255, 185, 184, 184))),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Image.network(
                                        brand_photo,
                                        height: 100,
                                        width: 130,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                // Text(description.split(' ')),
                              ],
                            )),
                      ),
                    );
                  },
                  itemCount: snapshot.data!.length,
                );
              }
            },
          )),
        )
      ],
    ));
  }
}
