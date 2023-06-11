import 'package:flutter/material.dart';
import 'package:ontime/model/e_shop.dart';
import 'package:ontime/pages/cart.dart';
import 'package:ontime/pages/make_order.dart';

class EShop extends StatefulWidget {
  final String category;
  const EShop({super.key, required this.category});

  @override
  State<EShop> createState() => _EShopState();
}

class _EShopState extends State<EShop> {
  bool isHidden = true;

  void toggleVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.category,
            style: TextStyle(color: Colors.black),
          ),
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
            Center(
                child: Card(
              child: FutureBuilder(
                future: getShopData(widget.category as String),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: Container(
                          height: 200, child: Center(child: Text("Loading"))),
                    );
                  } else {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 20),
                      itemBuilder: (context, index) {
                        var name = snapshot.data[index].title;
                        var price = snapshot.data[index].price;
                        var description = snapshot.data[index].description;
                        var image = snapshot.data[index].image;
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                onTap: () {
                                  print("clicked $name");
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MakeOrder(
                                            productName: name,
                                            productImage: image,
                                            productPrice: price,
                                            description: description,
                                            product_image_url: image as String,
                                          )));
                                },
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      child: Image.network(
                                        image,
                                        height: 100,
                                        width: 130,
                                      ),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      name.split(' ')[0],
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    // Text(description.split(' ')),
                                    Text(
                                      '\$${price}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                          ),
                        );
                      },
                      itemCount: snapshot.data.length,
                    );
                  }
                },
              ),
            )),
          ],
        ));
  }
}
