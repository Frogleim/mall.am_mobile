import 'dart:convert';

import 'package:http/http.dart' as http;

class CountHandler {
  String userEmail;
  String command;
  int count;
  String productName;

  CountHandler(
      {required this.userEmail,
      required this.command,
      required this.count,
      required this.productName});
}

Future<String> changeCounts(
  String cutomerEmail,
  String command,
  int count,
  String productName,
) async {
  final url = Uri.parse(
      'http://172.21.96.1/change_count'); // Replace with your API endpoint

  final headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final body = jsonEncode({
    'customer_email': cutomerEmail,
    'command': command,
    'count': count,
    'product_name': productName,
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
