import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> addCreditCard(String cutomerEmail, String cardholdername,
    String cardnumber, String date, String cvv) async {
  final url = Uri.parse(
      'http://172.27.144.1/add_card/'); // Replace with your API endpoint

  final headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final body = jsonEncode({
    'customer_email': cutomerEmail,
    'card_holder_name': cardholdername,
    'card_number': cardnumber,
    'date': date,
    'cvv': cvv
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
