import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> removeToCart(String cutomerEmail, String product_name) async {
  final url = Uri.parse(
      'http://172.21.96.1/remove_data'); // Replace with your API endpoint

  final headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final body = jsonEncode(
      {'customer_email': cutomerEmail, 'product_name': product_name});

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    // Request successful, handle the response
    print('Response: ${response.body}');
  } else {
    // Request failed, handle the error
    print('Error: ${response.statusCode}');
  }
  return response.body;
}

Future<String> removeAllCart(String cutomerEmail) async {
  final url = Uri.parse(
      'http://172.21.96.1/remove_all_cart'); // Replace with your API endpoint

  final headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final body = jsonEncode({'customer_email': cutomerEmail});

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    // Request successful, handle the response
    print('Response cart: ${response.body}');
  } else {
    // Request failed, handle the error
    print('Error: ${response.statusCode} ${response.body}');
  }
  return response.body;
}
