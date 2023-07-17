import 'package:http/http.dart' as http;
import 'dart:convert';

class CardInformation {
  final String customer_email;
  final String card_holder_name;
  final String card_number;
  final String date;
  final String cvv;

  CardInformation(
      {required this.customer_email,
      required this.card_holder_name,
      required this.card_number,
      required this.date,
      required this.cvv});
  factory CardInformation.fromJson(Map<String, dynamic> json) {
    return CardInformation(
        customer_email: json['customer_email'],
        card_holder_name: json['card_holder_name'],
        card_number: json['card_number'],
        date: json['date'],
        cvv: json['cvv']);
  }
}

Future getCardData(String customer_email) async {
  var response = await http.get(
      Uri.http("http://172.27.144.1/get_card_information/${customer_email}"));

  var jsonData = jsonDecode(response.body);

  if (response.statusCode == 200) {
    // Request successful, handle the response
    print('Response: ${response.body}');
  } else {
    // Request failed, handle the error
    print('Error: ${response.statusCode}');
  }

  List<CardInformation> cardData = [];
  for (var items in jsonData) {
    final card = CardInformation(
        customer_email: items['customer_email'],
        card_holder_name: items['card_holder_name'].toString(),
        card_number: items['card_number'],
        date: items['date'],
        cvv: items['cvv']);
    cardData.add(card);
  }

  print(cardData.length);
  return cardData;
}
