import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ontime/models/address_models/google_address.dart';

// 093383131 armen
class Gmaps extends StatefulWidget {
  const Gmaps({super.key});

  @override
  State<Gmaps> createState() => _GmapsState();
}

class _GmapsState extends State<Gmaps> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  TextEditingController _searchController = TextEditingController();

// 40.1778779001858, 44.51263550194168
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.1778779001858, 44.51263550194168),
    zoom: 14.4746,
  );

  Marker _kGoogleMarker = Marker(
    markerId: MarkerId('_KGooglePlex'),
    infoWindow: InfoWindow(title: 'Google Plex'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(40.1778779001858, 44.51263550194168),
  );

  CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(40.1778779001858, 44.51263550194168),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

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
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: _searchController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(hintText: 'Search'),
                onChanged: (value) {
                  print(value);
                },
              )),
              IconButton(
                  onPressed: () async {
                    print(_searchController.text.trim());
                    await LocationService()
                        .getPlace(_searchController.text.trim())
                        .then((value) {
                      for (var items in value) {
                        print(items.lat);
                        print(items.lng);
                        setState(() {
                          double lat = items.lat;
                          double lng = items.lng;

                          _kGooglePlex = CameraPosition(
                              target: LatLng(lat, lng), zoom: 14.4746);

                          _kGoogleMarker = Marker(
                              markerId: MarkerId('_KGooglePlex'),
                              infoWindow: InfoWindow(title: 'Google Plex'),
                              icon: BitmapDescriptor.defaultMarker,
                              position: LatLng(lat, lng));
                        });
                      }
                    });
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: {_kGoogleMarker},
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
