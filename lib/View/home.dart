import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ugd_4_hospital/View/grid.dart';
// import 'package:ugd_4_hospital/View/profile_kelompok.dart';
import 'package:ugd_4_hospital/View/chat.dart';
import 'package:ugd_4_hospital/View/setting.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

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
          // BottomNavigationBarItem(
          //     icon: Icon(Ionicons.people_outline), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Ionicons.settings_outline), label: 'Setting'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const GridWidget();
      case 1:
        return const Center(
          child: ChatPage(),
        );
      case 2:
        return const Center(
          child: Text('Index 2: Schedule'),
        );
      // case 3:
      //   return const Center(
      //     child: Profile(),
      //   );
      case 3:
        return const Center(
          child: SettingView(),
        );
      default:
        return const Center(
          child: Text('Not Implemented'),
        );
    }
  }
}
