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

Future<UserAddress> getAddress(String cutomerEmail) async {
  final url = Uri.parse(
      'http://16.171.132.175/address/$cutomerEmail'); // Replace with your API endpoint

  final response = await http.get(url);
  var jsonData = jsonDecode(response.body);
  print(jsonData);

  if (jsonData != null) {
    UserAddress addressData = UserAddress(
      userEmail: jsonData['customer_email'],
      street: jsonData['street'],
      city: jsonData['city'],
      zipcode: jsonData['zipcode'],
      country: jsonData['country'],
    );
    print(addressData);
    return addressData;
  } else {
    throw Exception('Failed to fetch address data');
  }
}
