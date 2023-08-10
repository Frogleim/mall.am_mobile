import 'dart:convert';

import 'package:http/http.dart' as http;

class UserCart {
  String userEmail;
  String productName;
  String shopName;
  int count;
  String productImage;
  double productPrice;
  double productTotalPrice;

  UserCart(
      {required this.userEmail,
      required this.productName,
      required this.shopName,
      required this.count,
      required this.productImage,
      required this.productPrice,
      required this.productTotalPrice});
}

Future cart(String cutomerEmail) async {
  final url = Uri.parse(
      'http://172.21.96.1/cart/$cutomerEmail'); // Replace with your API endpoint

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
  for (var items in jsonData['Message']) {
    UserCart cartItems = UserCart(
        userEmail: items[1],
        productName: items[2],
        shopName: items[3],
        count: items[4],
        productImage: items[5],
        productPrice: items[6],
        productTotalPrice: items[7]);
    cartData.add(cartItems);
  }
  print(cartData.length);
  return cartData;
}

Future totalPrice(String userEmail) async {
  final url = Uri.parse('http://172.21.96.1/total_price/$userEmail');

  final headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final response = await http.get(url, headers: headers);
  var jsonData = jsonDecode(response.body);
  print(jsonData);
  return response.body;
}
