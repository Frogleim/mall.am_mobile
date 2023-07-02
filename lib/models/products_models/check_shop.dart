import 'package:http/http.dart' as http;
import 'dart:convert';

Future checkShops(String shop_name) async {
  var response =
      await http.get(Uri.parse("http://192.168.18.206/check_shop/$shop_name"));
  var jsonData = jsonDecode(response.body);
  return jsonData;
}
