import 'package:http/http.dart' as http;
import 'dart:convert';

class Brand {
  final String brand_name;
  final String brand_photo;

  Brand({required this.brand_name, required this.brand_photo});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
        brand_name: json['brand_name'], brand_photo: json['brand_photo']);
  }
}

List<Brand> cardData = [];

Future<List<Brand>> getBrands() async {
  var response = await http.get(Uri.parse("http://192.168.18.206/brands"));
  var jsonData = jsonDecode(response.body);
  for (var items in jsonData) {
    final brands = Brand(
        brand_name: items['brand_name'], brand_photo: items['brand_photo']);
    cardData.add(brands);
  }
  print(cardData.length);
  return cardData;
}
