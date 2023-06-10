import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ontime/pages/account.dart';
import 'package:ontime/pages/cards_pages/add_card.dart';
import 'package:ontime/pages/home_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    AddCard(),
    Account(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.black,
        buttonBackgroundColor: Colors.black,
        height: 60,
        backgroundColor: Colors.transparent,
        items: const [
          Icon(
            Icons.home_filled,
            color: Colors.white,
          ),
          Icon(
            Icons.wallet,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
          )
        ],
        onTap: _onItemTapped,
      ),
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
