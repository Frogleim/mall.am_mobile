import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';
import 'package:ontime/model/products_api.dart';
import 'package:ontime/pages/account_pages/account.dart';
import 'package:ontime/pages/make_order.dart';

class Coffee extends StatefulWidget {
  const Coffee({super.key});

  @override
  State<Coffee> createState() => _CoffeeState();
}

class _CoffeeState extends State<Coffee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Account()));
            },
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://i.pinimg.com/564x/a7/da/a4/a7daa4792ad9e6dc5174069137f210df.jpg"),
            ),
          )
        ],
      ),
      body: Center(
          child: Card(
        child: FutureBuilder(
          future: getCoffeeData(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Container(
                    height: 200, child: Center(child: Text("Loading"))),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  var name = snapshot.data[index].name;
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
                                    product_image_url: image,
                                  )));
                        },
                        child: FillImageCard(
                          width: 350,
                          title: Text(
                            name,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          imageProvider: NetworkImage('https://$image'),
                          description: Text(
                            description,
                            style: const TextStyle(color: Colors.black),
                          ),
                          footer: Text(
                            '$price',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data.length,
              );
            }
          },
        ),
      )),
    );
  }
}
