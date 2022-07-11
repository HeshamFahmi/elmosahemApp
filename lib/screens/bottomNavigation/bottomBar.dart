// ignore_for_file: file_names

import 'package:elmosahem_app/constants.dart';
import 'package:elmosahem_app/screens/fav/favorite.dart';
import 'package:elmosahem_app/screens/my_orders/my_orders_screen.dart';
import 'package:elmosahem_app/screens/profile.dart/profile.dart';
import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import 'customBottomNavigationBar.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kPrimaryColor,
        currentIndex: _selectedIndex,
        unselectedItemColor: kSecondaryColor,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          custombottomNavBar("الرئيسية", Icons.home),
          custombottomNavBar("المفضله", Icons.favorite),
          custombottomNavBar("المحفظه", Icons.wallet),
          custombottomNavBar("الصفحه الشخصيه", Icons.settings),
        ],
      ),
      body: Center(child: _pages.elementAt(_selectedIndex)),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _pages = <Widget>[
    HomeScreen(),
    Favorite(),
    MyOrdersScreen(),
    Profile(),
  ];
}
