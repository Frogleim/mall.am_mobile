import 'package:flutter/material.dart';
import 'package:ontime/models/products_models/check_shop.dart';
import 'package:ontime/pages/error_page.dart';
import 'package:ontime/pages/products/coffee_house.dart';
import 'package:ontime/pages/products/eshop_category.dart';
import 'package:ontime/pages/products/shop.dart';

class CheckShop extends StatefulWidget {
  final String shop_name;
  const CheckShop({super.key, required this.shop_name});

  @override
  State<CheckShop> createState() => _CheckShopState();
}

class _CheckShopState extends State<CheckShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: checkShops(widget.shop_name as String),
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.data['type'] == 'asos') {
          return Coffee();
        } else if (snapshot.data['type'] == "mall") {
          return ShopCategory();
        } else {
          return ErrorPage();
        }
      },
    ));
  }
}
