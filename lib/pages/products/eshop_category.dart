import 'package:flutter/material.dart';
import 'package:ontime/pages/account.dart';
import 'package:ontime/pages/products/shop.dart';

class ShopCategory extends StatefulWidget {
  const ShopCategory({super.key});

  @override
  State<ShopCategory> createState() => _ShopCategoryState();
}

class _ShopCategoryState extends State<ShopCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('eShop Categories'),
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
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: GestureDetector(
              onTap: () {
                print('Clicked electronics');
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        const EShop(category: 'electronics')));
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    'https://i.pinimg.com/564x/e9/a1/42/e9a1423e253d9b62686f7231e1b721e4.jpg', // Replace with the path to your image asset
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.white,
              child: GestureDetector(
                onTap: () {
                  print('Clicked');
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const EShop(category: 'jewelery')));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2.0),
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      'https://i.pinimg.com/564x/e3/ec/e1/e3ece1792efd31a5ac525074a289cf0e.jpg', // Replace with the path to your image asset
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: GestureDetector(
              onTap: () {
                print('Clicked');
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        const EShop(category: "men's clothing")));
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    'https://i.pinimg.com/564x/dc/c4/bf/dcc4bf2e838b8213f020abaa0241c3d8.jpg', // Replace with the path to your image asset
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: GestureDetector(
              onTap: () {
                print("Clicked");
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        const EShop(category: "women's clothing")));
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    'https://i.pinimg.com/564x/72/ab/5f/72ab5fe599abd7de96cc842f7b15f133.jpg', // Replace with the path to your image asset
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
