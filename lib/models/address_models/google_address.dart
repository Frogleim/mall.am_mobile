import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class Places {
  final String formattedAddress;
  final double lat;
  final double lng;

  Places(
      {required this.formattedAddress, required this.lat, required this.lng});
}

class LocationService {
  final String key = 'AIzaSyD_4Quaad6a5-ULGV0t0l8ZFZoz-b4aY1E';

  Future getAddressFromLatLng(double lat, double lng) async {
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$_host?key=$key&language=en&latlng=$lat,$lng';
    if (lat != null && lng != null) {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        String _formattedAddress = data["results"][0]["formatted_address"];
        print("response ==== $_formattedAddress");
        return _formattedAddress;
      } else
        return null;
    } else
      return null;
  }

  Future<String> getAddressFromCoordinates(
      double latidute, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latidute, longitude);
      // ignore: unnecessary_null_comparison
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String address =
            "${placemark.street}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}";
        return address;
      }
    } catch (e) {
      print('Error: $e');
    }
    return '';
  }

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
