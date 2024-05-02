import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Acceuil",
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: "Les contacts"
        ),
      ],
      type: BottomNavigationBarType.fixed,
      elevation: 32,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black,
      selectedFontSize: 20,
      currentIndex: _selectedIndex,
      onTap: (int _index) {
        setState(() {
          _selectedIndex = _index;
        });
      },
    );
  }
}

