import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ontime/models/address_models/get_address.dart';

Future<void> checkAddress(String customerEmail) async {
  final url = Uri.parse('http://192.168.18.206/address/$customerEmail');
  final headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    // Request successful, handle the response
    var jsonData = jsonDecode(response.body);

    List<UserAddress> cartData = [];
    for (var items in jsonData) {
      UserAddress cartItems = UserAddress(
        userEmail: items['customer_email'],
        street: items['street'],
        city: items['city'],
        zipcode: items['zipcode'],
        country: items['country'],
      );
      cartData.add(cartItems);
    }
    print('Response data: $cartData');

    if (cartData.isNotEmpty) {
      // Data is available, navigate to MyAddress() page
      navigateToMyAddress(cartData);
    } else {
      // Data is not available, navigate to AddAddress() page
      navigateToAddAddress();
    }
  } else {
    // Request failed, handle the error
    print('Error: ${response.statusCode}');
  }
}

void navigateToMyAddress(List<UserAddress> addresses) {
  // Implement your logic to navigate to MyAddress() page
  print('Navigating to MyAddress() page...');
  // Example: Navigator.push(context, MaterialPageRoute(builder: (_) => MyAddressPage(addresses)));
}

void navigateToAddAddress() {
  // Implement your logic to navigate to AddAddress() page
  print('Navigating to AddAddress() page...');
  // Example: Navigator.push(context, MaterialPageRoute(builder: (_) => AddAddressPage()));
}
