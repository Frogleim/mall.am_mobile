import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> addAddress(
  String cutomerEmail,
  String address,
) async {
  final url = Uri.parse(
      'http://172.27.144.1/add_address/'); // Replace with your API endpoint

  final headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final body = jsonEncode({'customer_email': cutomerEmail, 'address': address});

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

// Future addAddress(String email, String address) async {
//   await FirebaseFirestore.instance
//       .collection('users_shipping_address')
//       .add({"customer_email": email, "address": address});
// }
