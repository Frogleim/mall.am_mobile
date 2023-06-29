import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Places {
  final String formattedAddress;
  final double lat;
  final double lng;

  Places(
      {required this.formattedAddress, required this.lat, required this.lng});
}

class LocationService {
  final String key = 'AIzaSyD_4Quaad6a5-ULGV0t0l8ZFZoz-b4aY1E';

  Future getPlace(String input) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=${Uri.encodeComponent(input)}%20Australia&inputtype=textquery&fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry&key=$key";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      if (jsonResponse['candidates'] != null &&
          jsonResponse['candidates'].isNotEmpty) {
        List<Places> formattedAddresses = [];
        for (var place in jsonResponse['candidates']) {
          String formattedAddress = place['formatted_address'];
          dynamic location = place['geometry']['location'];
          double lat = location['lat'];
          double lng = location['lng'];
          Places placesObj =
              Places(formattedAddress: formattedAddress, lat: lat, lng: lng);

          formattedAddresses.add(placesObj);
          print(formattedAddresses);
        }
        return formattedAddresses;
      } else {
        print('No place found.');
        return [];
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
      return [];
    }
  }
}
