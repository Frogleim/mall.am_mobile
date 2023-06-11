import 'package:flutter/material.dart';
import 'package:ontime/pages/cart.dart';
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
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Cart()));
                },
                child: Icon(Icons.shopping_basket_outlined)),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: Stack(
          children: [
            const Positioned(
                top: 50,
                left: 20,
                child: Text(
                  'Categories',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                )),
            Positioned(
                top: 100,
                left: 20,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EShop(category: 'electronics')));
                  },
                  child: Container(
                    width: 100,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(35)),
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Icon(
                          Icons.computer,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Electronics',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        Text(
                          '10 Products',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )),
            Positioned(
                top: 200,
                left: 20,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EShop(category: 'jewelery')));
                  },
                  child: Container(
                    width: 100,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(35)),
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Icon(
                          Icons.diamond,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Jewelery',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: 90,
                        ),
                        Text(
                          '10 Products',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )),
            Positioned(
                top: 300,
                left: 20,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            EShop(category: "men's clothing")));
                  },
                  child: Container(
                    width: 100,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(35)),
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Icon(
                          Icons.shopping_bag,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Men Clothes',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        Text(
                          '10 Products',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )),
            Positioned(
                top: 400,
                left: 20,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            EShop(category: "women's clothing")));
                  },
                  child: Container(
                    width: 100,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(35)),
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Women Clothes',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Text(
                          '10 Products',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ));
  }
}
