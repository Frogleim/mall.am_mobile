import 'dart:convert';

import 'package:http/http.dart' as http;

class UserCart {
  String product_name;
  String product_price;
  String product_image_url;
  int count;

  UserCart(
      {required this.product_name,
      required this.product_price,
      required this.product_image_url,
      required this.count});

  void incrementCount() {
    count++;
  }

  void decrementCount() {
    if (count > 1) {
      count--;
    }
  }

  factory UserCart.fromJson(Map<String, dynamic> json) {
    return UserCart(
        product_name: json['product_name'],
        product_price: json['product_price'],
        product_image_url: json['product_image_url'],
        count: json['count']);
  }
}

Future cart(String cutomerEmail) async {
  final url = Uri.parse(
      'http://172.25.160.1/cart/$cutomerEmail'); // Replace with your API endpoint

  final headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final response = await http.get(url, headers: headers);
  var jsonData = jsonDecode(response.body);

  if (response.statusCode == 200) {
    // Request successful, handle the response
    print('Response: ${response.body}');
  } else {
    // Request failed, handle the error
    print('Error: ${response.statusCode}');
  }
  List<UserCart> cartData = [];
  for (var items in jsonData) {
    UserCart cartItems = UserCart(
        product_name: items['product_name'],
        product_price: items['product_price'],
        product_image_url: items['product_image_url'],
        count: items['count']);
    cartData.add(cartItems);
  }
  print(cartData.length);
  return cartData;
}
