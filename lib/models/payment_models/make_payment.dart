import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> makePayment(String productName, String productPrice) async {
  final url = Uri.parse(
      'http://172.25.160.1/make_order'); // Replace with your API endpoint

  final headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final body = jsonEncode({
    'product_name': productName,
    'product_price': productPrice,
  });

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    // Request successful, handle the response
    print('Response: ${response.body}');
  } else {
    // Request failed, handle the error
    print('Error: ${response.statusCode}');
  }
}
