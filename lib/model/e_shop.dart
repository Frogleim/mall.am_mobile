import 'package:http/http.dart' as http;
import 'dart:convert';

class Shop {
  final int id;
  final String title;
  final String price;
  final String category;
  final String description;
  final String image;

  Shop(
      {required this.id,
      required this.title,
      required this.price,
      required this.category,
      required this.description,
      required this.image});
  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        category: json['category'],
        description: json['description'],
        image: json['image']);
  }
}

Future getShopData(category_name) async {
  var response = await http.get(
      Uri.parse("https://fakestoreapi.com/products/category/$category_name"));

  var jsonData = jsonDecode(response.body);

  List<Shop> eshop = [];
  for (var items in jsonData) {
    Shop shop = Shop(
        id: items['id'],
        title: items['title'],
        price: items['price'].toString(),
        category: items['category'],
        description: items['description'],
        image: items['image']);
    eshop.add(shop);
  }
  print(eshop.length);
  return eshop;
}
