import 'package:http/http.dart' as http;

Future checkCardInformation(String customerEmail) async {
  final url = Uri.parse(
      'http://192.168.18.206/check_card_information/$customerEmail'); // Replace with your API endpoint

  final headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final response = await http.get(url, headers: headers);
  print(response.body);

  return response.body;
}
