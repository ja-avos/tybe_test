import 'package:flutter/material.dart';
import 'package:tyba_test/src/Orders/ui/screens/order_history_screen.dart';
import 'package:tyba_test/src/Restaurants/ui/screens/restaurant_screen.dart';
import 'package:tyba_test/src/User/ui/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int currentIndex;

  static final List<Widget> _pages = [
    const RestaurantsScreen(),
    OrderHistory(),
    ProfileScreen(),
  ];

  _HomeScreenState({this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _pages.elementAt(currentIndex),
      )),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 28,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Restaurantes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
