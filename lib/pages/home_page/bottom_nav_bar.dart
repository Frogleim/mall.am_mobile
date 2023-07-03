import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ontime/pages/account_pages/account.dart';
import 'package:ontime/pages/cart/cart.dart';
import 'package:ontime/pages/home_page/home_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Cart(),
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
      bottomNavigationBar: GNav(
        gap: 8,
        hoverColor: Colors.grey[100]!,
        rippleColor: Colors.grey[300]!,
        tabBackgroundColor: Colors.grey[100]!,
        color: Colors.black,
        backgroundColor: Colors.white,
        tabs: const [
          GButton(
            icon: Icons.home_filled,
            text: 'Home',
          ),
          GButton(
            icon: Icons.shopping_cart,
            text: 'My Cart',
          ),
          GButton(
            icon: Icons.person,
            text: 'Account',
          ),
        ],
        onTabChange: _onItemTapped,
      ),
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
