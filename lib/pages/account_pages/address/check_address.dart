import 'package:error_message/error_message.dart';
import 'package:flutter/material.dart';
import 'package:ontime/models/address_models/get_address.dart';
import 'package:ontime/models/get_user_email.dart';
import 'package:ontime/pages/account_pages/address/address.dart';
import 'package:ontime/pages/account_pages/address/gmap.dart';

class CheckAddress extends StatefulWidget {
  const CheckAddress({super.key});

  @override
  State<CheckAddress> createState() => _CheckAddressState();
}

class _CheckAddressState extends State<CheckAddress> {
  late final userEmail = getEmail();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getAddress(userEmail),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          } else if (snapshot.hasError || snapshot.data == null) {
            return const Gmaps();
          } else if (snapshot.hasData && snapshot.data != null) {
            // Data is available
            print(snapshot.data!.street);
            print(snapshot.data!.city);
            print(snapshot.data!.country);
            print(snapshot.data!.zipcode);
            String fullAddress =
                '${snapshot.data!.street}, ${snapshot.data!.city}, ${snapshot.data!.country}, ${snapshot.data!.zipcode}';

            return MyAddress(myAddress: fullAddress);
          } else {
            // Data is not available or empty
            return const Center(
              child: ErrorMessage(
                icon: Icon(Icons.warning_rounded),
                title: "Something went wrong!",
              ),
            );
          }
        },
      ),
    );
  }
}
