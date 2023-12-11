import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ugd_4_hospital/View/beranda.dart';
// import 'package:ugd_4_hospital/View/CheckIn/check_in.dart';
import 'package:ugd_4_hospital/View/Pasien/pasienView.dart';
import 'package:ugd_4_hospital/View/Chat/chat.dart';
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
        selectedItemColor: const Color(0xff15C73C),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Ionicons.home_outline), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Ionicons.chatbubble_ellipses_outline), label: 'Chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital_outlined), label: 'Pasien'),
          BottomNavigationBarItem(
              icon: Icon(Ionicons.settings_outline), label: 'Setting'),
          // BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Check-In'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 1:
        return Center(
          child: ChatPage(),
        );
      case 2:
        return Center(
          child: ProviderScope(child: PasienView()),
        );
      case 3:
        return Center(
          child: SettingView(),
        );
      // case 4:
      //   return Center(
      //     child: CheckInPage(),
      //   );
      default:
        return Center(
          child: BerandaView(),
        );
    }
  }
}
