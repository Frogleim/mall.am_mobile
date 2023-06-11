import 'package:http/http.dart' as http;
import 'dart:convert';

class CardInformation {
  final int id;
  final String customer_email;
  final String card_holder_name;
  final String card_type;
  final String card_number;
  final String date;
  final String cvv;

  CardInformation(
      {required this.id,
      required this.customer_email,
      required this.card_holder_name,
      required this.card_type,
      required this.card_number,
      required this.date,
      required this.cvv});
  factory CardInformation.fromJson(Map<String, dynamic> json) {
    return CardInformation(
        id: json['id'],
        customer_email: json['title'],
        card_holder_name: json['price'],
        card_type: json['category'],
        card_number: json['description'],
        date: json['image'],
        cvv: json['cvv']);
  }
}

Future getCardData(String customer_email) async {
  var response = await http.get(Uri.parse(
      "http://192.168.18.110/check_card_information/${customer_email}"));

  var jsonData = jsonDecode(response.body);

  List<CardInformation> cardData = [];
  for (var items in jsonData) {
    CardInformation card = CardInformation(
        id: items['id'],
        customer_email: items['title'],
        card_holder_name: items['price'].toString(),
        card_type: items['category'],
        card_number: items['description'],
        date: items['image'],
        cvv: items['cvv']);
    cardData.add(card);
  }

  print(cardData.length);
  return cardData;
}
