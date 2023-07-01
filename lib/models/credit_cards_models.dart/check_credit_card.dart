import 'package:http/http.dart' as http;
import 'dart:convert';

class CheckCardInformation {
  final String customer_email;
  final String card_holder_name;
  final String card_number;
  final String date;
  final String cvv;

  CheckCardInformation(
      {required this.customer_email,
      required this.card_holder_name,
      required this.card_number,
      required this.date,
      required this.cvv});
  factory CheckCardInformation.fromJson(Map<String, dynamic> json) {
    return CheckCardInformation(
        customer_email: json['customer_email'],
        card_holder_name: json['card_holder_name'],
        card_number: json['card_number'],
        date: json['date'],
        cvv: json['cvv']);
  }
}

Future checkCardData(String customer_email) async {
  var response = await http.get(Uri.parse(
      "http://192.168.18.206/check_card_information/${customer_email}"));

  var jsonData = jsonDecode(response.body);
  print(jsonData);
  if (jsonData == 0) {
    return true;
  } else {
    return false;
  }
}
