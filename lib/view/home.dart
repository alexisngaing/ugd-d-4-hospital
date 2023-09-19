import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ugd_4_hospital/view/grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    GridWidget(),
    Center(
      child: Text(
        'Index 1: Chat',
      ),
    ),
    Center(
      child: Text(
        'Index 2: Schedule',
      ),
    ),
    Center(
      child: Text(
        'Index 3: Settings',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Ionicons.home_outline), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Ionicons.chatbubble_ellipses_outline), label: 'Chat'),
          BottomNavigationBarItem(
              icon: Icon(Ionicons.calendar_outline), label: 'Schedule'),
          BottomNavigationBarItem(
              icon: Icon(Ionicons.settings_outline), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: SingleChildScrollView(
          child: Center(child: _widgetOptions.elementAt(_selectedIndex))),
    );
  }
}
