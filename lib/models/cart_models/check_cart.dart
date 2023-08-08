import 'package:http/http.dart' as http;

Future checkCart(String customerEmail) async {
  final url = Uri.parse(
      'http://172.25.160.1/check_cart/$customerEmail'); // Replace with your API endpoint

  final headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final response = await http.get(url, headers: headers);
  print(response.body);

  return response.body;
}
