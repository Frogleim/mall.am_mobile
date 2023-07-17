import 'package:http/http.dart' as http;
import 'dart:convert';

class Coffee {
  final int id;
  final String name;
  final String price;
  final String description;
  final String image;

  Coffee(
      {required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.image});

  factory Coffee.fromJson(Map<String, dynamic> json) {
    return Coffee(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        description: json['description'],
        image: json['image']);
  }
}

Future getCoffeeData() async {
  var response = await http.get(Uri.parse("http://172.27.144.1/clothes"));

  var jsonData = jsonDecode(response.body);

  List<Coffee> coffees = [];
  for (var items in jsonData['products']) {
    Coffee coffee = Coffee(
        id: items['id'],
        name: items['brandName'],
        price: items['price']['current']['text'],
        description: items['name'],
        image: items['imageUrl']);
    coffees.add(coffee);
  }
  print(coffees.length);
  return coffees;
}
