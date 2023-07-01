import 'package:error_message/error_message.dart';
import 'package:flutter/material.dart';
import 'package:ontime/models/credit_cards_models.dart/check_credit_card.dart';
import 'package:ontime/models/get_user_email.dart';
import 'package:ontime/pages/account_pages/address/gmap.dart';
import 'package:ontime/pages/cards_pages/fill_card_info.dart';
import 'package:ontime/pages/cards_pages/wallet.dart';

class CheckWallet extends StatefulWidget {
  const CheckWallet({super.key});

  @override
  State<CheckWallet> createState() => _CheckAddressState();
}

class _CheckAddressState extends State<CheckWallet> {
  late final userEmail = getEmail();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkCardData(userEmail),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          } else if (snapshot.data == false) {
            print(snapshot.data);
            return const Gmaps();
          } else if (snapshot.hasData && snapshot.data == true) {
            // Data is available

            return Wallet();
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
