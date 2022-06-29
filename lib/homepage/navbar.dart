import 'package:flutter/material.dart';
import 'package:Myfin/custom_icon_icons.dart';
import 'package:Myfin/homepage/dashboard_page.dart';
import 'package:Myfin/homepage/profile_page.dart';
import 'package:Myfin/homepage/transaksi_page.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const Navbar(),
    );
  }

  @override
  State<Navbar> createState() => _NavbarState();
}


class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;
  final List<Widget> body = [Dashboard(), Transaksi(), Profile()];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: body[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  CustomIcon.house,
                  color: Colors.black,
                ),
                label: 'Dashboard',
                activeIcon: Icon(CustomIcon.house, color: Color(0xff6D597A))),
            BottomNavigationBarItem(
                icon: Icon(
                  CustomIcon.newspaper,
                  color: Colors.black,
                ),
                label: 'Transaksi',
                activeIcon: Icon(CustomIcon.newspaper, color: Color(0xff6D597A))),
            BottomNavigationBarItem(
                icon: Icon(
                  CustomIcon.account,
                  color: Colors.black,
                ),
                label: 'Profile',
                activeIcon: Icon(CustomIcon.account, color: Color(0xff6D597A))),
          ],
          onTap: onItemTapped,
          iconSize: 26,
          unselectedLabelStyle: TextStyle(
              fontFamily: 'Roboto', fontWeight: FontWeight.w600, fontSize: 10),
          selectedLabelStyle: TextStyle(
              fontFamily: 'Roboto', fontWeight: FontWeight.w600, fontSize: 10),
          unselectedItemColor: Colors.black,
          selectedItemColor: Color(0xff6D597A),
          currentIndex: _selectedIndex,
        ),
      ),
    );
  }
}
