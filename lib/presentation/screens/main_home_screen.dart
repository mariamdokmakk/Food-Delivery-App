import 'package:flutter/material.dart';
import '/presentation/screens/home_screen.dart';
import '/presentation/screens/orders_screen.dart';
import '/presentation/screens/profile_screen.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _index = 0;

  final List pages = [
    const HomeScreen(),
    const OrdersMainScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,

        selectedItemColor: Theme.of(context).colorScheme.primary,

        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
