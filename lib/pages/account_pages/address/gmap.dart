import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:ontime/models/address_models/add_address.dart';
import 'package:ontime/models/address_models/google_address.dart';
import 'package:ontime/models/constants.dart';
import 'package:ontime/models/get_user_email.dart';
import 'package:ontime/pages/account_pages/address/address.dart';

class Gmaps extends StatefulWidget {
  const Gmaps({super.key});

  @override
  State<Gmaps> createState() => _GmapsState();
}

class _GmapsState extends State<Gmaps> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late double lt;
  late double lng;
  String? clientAddress;

  TextEditingController _searchController = TextEditingController();
  Set<Marker> _markers = Set<Marker>();
  Timer? _debounce;
  List<LatLng> polygonLatLngs = <LatLng>[];
  List<AutocompletePrediction> predictions = [];
  late FocusNode searchNode;
  late GooglePlace googlePlace;
  DetailsResult? searchAddress;

  String address = '';
  void updateAddress(String newAddress) {
    setState(() {
      address = newAddress;
    });
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      // print('This is prediction ${result.predictions!.first.description}');
      setState(() {
        predictions = result.predictions!;
        print('This is prediction $predictions');
      });
    } else {
      print('No matches');
    }
  }

// 40.1778779001858, 44.51263550194168
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.1778779001858, 44.51263550194168),
    zoom: 14.4746,
  );

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('marker'),
          position: point,
        ),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setMarker(LatLng(40.1778779001858, 44.51263550194168));
    googlePlace = GooglePlace(apiKey);
    searchNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    searchNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
        title: const Text(
          'Add Address',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: _markers,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: (LatLng latLing) {
                lt = latLing.latitude;
                lng = latLing.longitude;
                print(lt);
                print(lng);
                _goToPlace(lt, lng);
                setState(() {
                  LocationService()
                      .getAddressFromCoordinates(lt, lng)
                      .then((value) {
                    clientAddress = value;
                    print(clientAddress);
                  });
                });
              },
            ),
          ),
          Container(
            width: 200,
            child: ElevatedButton.icon(
              onPressed: () {
                print('This is new $lt and $lng');
                var email = getEmail();
                addAddress(email, clientAddress!);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: success,
                        content:
                            Text('Your delivery address:\n\n $clientAddress'),
                        actions: [
                          TextButton(
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      MyAddress(myAddress: clientAddress!)));
                            },
                            icon: const Icon(
                              Icons.arrow_right,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Submit',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: textColorLightTheme,
                                elevation: 0,
                                fixedSize: const Size(double.infinity, 40),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                          )
                        ],
                      );
                    });
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: const Text(
                'Add Address',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: textColorLightTheme,
                  elevation: 0,
                  fixedSize: const Size(double.infinity, 40),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _goToPlace(double lat, double lng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 20),
      ),
    );
    _setMarker(LatLng(lat, lng));
  }
}
