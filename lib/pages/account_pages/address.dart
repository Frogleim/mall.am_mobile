import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_place/google_place.dart';
import 'package:ontime/model/constants.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final _searchAddressController = TextEditingController();
  String locationMessage = "User location is: ";
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? _debounce;

  DetailsResult? searchAddress;

  late FocusNode searchNode;
  late String lat;
  late String lon;
  String address = '';

  void updateAddress(String newAddress) {
    setState(() {
      address = newAddress;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    googlePlace = GooglePlace(apiKey);
    searchNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    searchNode.dispose();
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      print(result.predictions!.first.description);
      setState(() {
        predictions = result.predictions!;
      });
    } else {
      print('No matches');
    }
  }

  void _livLocation() {
    LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 100);

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      lon = position.longitude.toString();
      setState(() {
        locationMessage = 'Latitude: $lat, Longitude: $lon';
      });
    });
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled");
    }

    LocationPermission premissions = await Geolocator.checkPermission();
    if (premissions == LocationPermission.denied) {
      premissions = await Geolocator.requestPermission();
      if (premissions == LocationPermission.denied) {
        return Future.error("Location Premissions are denied");
      }
    }
    if (premissions == LocationPermission.deniedForever) {
      return Future.error(
          "Location premissions are permanently denied, we cannot send requests");
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<String> getAddressFromCoordinates(
      double latidute, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latidute, longitude);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
                child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: TextFormField(
                focusNode: searchNode,
                controller: _searchAddressController,
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                  _debounce = Timer(const Duration(milliseconds: 1000), () {
                    if (value.isNotEmpty) {
                      autoCompleteSearch(value);
                    } else {}
                  });
                },
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                    suffixIcon: _searchAddressController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                predictions = [];
                                _searchAddressController.clear();
                              });
                            },
                            icon: const Icon(
                              Icons.clear_outlined,
                              color: Colors.black,
                            ))
                        : null,
                    hintText: "Search Your Location",
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Icon(Icons.search),
                    )),
              ),
            )),
            const Divider(
              height: 4,
              thickness: 4,
              color: secondaryColor5LightTheme,
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: ElevatedButton.icon(
                onPressed: () {
                  getCurrentLocation().then((value) {
                    lat = '${value.latitude}';
                    lon = '${value.longitude}';
                    setState(() {
                      locationMessage = 'Latitude: $lat, Longitude: $lon';
                      getAddressFromCoordinates(
                          double.parse(lat), double.parse(lon));
                    });
                    _livLocation();
                  });
                },
                icon: const Icon(Icons.location_on),
                label: const Text('Use my Current localtion'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor10LightTheme,
                    foregroundColor: textColorLightTheme,
                    elevation: 0,
                    fixedSize: const Size(double.infinity, 40),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),
            const Divider(
              height: 4,
              thickness: 4,
              color: secondaryColor5LightTheme,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: predictions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.pin_drop,
                        color: Colors.black,
                      ),
                    ),
                    title: Text(predictions[index].description.toString()),
                    onTap: () async {
                      final placeId = predictions[index].placeId!;
                      final details = await googlePlace.details.get(placeId);
                      if (details != null &&
                          details.result != null &&
                          mounted) {
                        if (searchNode.hasFocus) {
                          setState(() {
                            searchAddress = details.result;
                            _searchAddressController.text =
                                details.result!.name!;

                            predictions = [];
                          });
                        } else {}
                      }
                    },
                  );
                }),
            SizedBox(
              height: 100,
            ),
            Text('Your address: $address'),
          ],
        ),
      ),
    );
  }
}
