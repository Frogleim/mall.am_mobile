import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> addToCart(
  String cutomerEmail,
  String productName,
  String shopName,
  int count,
  String productImage,
  String productPrice,
  String productTotalPrice,
) async {
  final url = Uri.parse(
      'http://172.21.96.1/add_to_cart'); // Replace with your API endpoint

  final headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final body = jsonEncode({
    'customer_email': cutomerEmail,
    'product_name': productName,
    'shop_name': shopName,
    'count': count,
    'product_image_url': productImage,
    'product_price': productPrice,
    'product_total_price': productTotalPrice,
  });

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    // Request successful, handle the response
    print('Response: ${response.body}');
  } else {
    // Request failed, handle the error
    print('Error: ${response.statusCode}');
    print('Response Body: ${response.body}');
  }
  return response.body;
}
