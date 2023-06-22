import 'dart:convert';
import 'package:http/http.dart' as http;

class UserAddress {
  final String userEmail;
  final String street;
  final String city;
  final String zipcode;
  final String country;

  UserAddress(
      {required this.userEmail,
      required this.street,
      required this.city,
      required this.zipcode,
      required this.country});
  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
        userEmail: json['customer_email'],
        street: json['street'],
        city: json['city'],
        zipcode: json['zipcode'],
        country: json['country']);
  }
}

Future address(String cutomerEmail) async {
  final url = Uri.parse(
      'http://192.168.18.110/address/$cutomerEmail'); // Replace with your API endpoint

  final headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final response = await http.get(url, headers: headers);
  var jsonData = jsonDecode(response.body);

  if (response.statusCode == 200) {
    // Request successful, handle the response
    print('Response: 1 ${response.body}');
  } else {
    // Request failed, handle the error
    print('Error: ${response.statusCode}');
  }
  List<UserAddress> cartData = [];
  for (var items in jsonData) {
    UserAddress cartItems = UserAddress(
        userEmail: items['customer_email'],
        street: items['street'],
        city: items['city'],
        zipcode: items['zipcode'],
        country: items['country']);
    cartData.add(cartItems);
  }
  print('Response data: ${cartData}');
  return cartData;
}
