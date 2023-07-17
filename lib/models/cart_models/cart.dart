import 'dart:convert';

import 'package:http/http.dart' as http;

class Cart {
  final int order_id;
  final String product_name;
  final String product_price;
  final String product_image;

  Cart({
    required this.order_id,
    required this.product_name,
    required this.product_price,
    required this.product_image,
  });
  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
        order_id: json['order_id'],
        product_name: json['product_name'],
        product_price: json['product_price'],
        product_image: json['product_image_url']);
  }
}

Future cart(String cutomerEmail) async {
  final url = Uri.parse(
      'http://172.27.144.1/cart/$cutomerEmail'); // Replace with your API endpoint

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
  List<Cart> cartData = [];
  for (var items in jsonData) {
    Cart cartItems = Cart(
        order_id: items['order_id'],
        product_name: items['product_name'],
        product_price: items['product_price'],
        product_image: items['product_image_url']);
    cartData.add(cartItems);
  }
  return cartData;
}
