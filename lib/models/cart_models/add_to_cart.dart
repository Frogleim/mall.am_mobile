import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> addToCart(String cutomerEmail, String productName,
    String productPrice, String product_image_url, String count) async {
  final url = Uri.parse(
      'http://172.25.160.1/add_to_cart'); // Replace with your API endpoint

  final headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final body = jsonEncode({
    'customer_email': cutomerEmail,
    'product_name': productName,
    'product_price': productPrice,
    'product_image_url': product_image_url,
    'count': count
  });

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
