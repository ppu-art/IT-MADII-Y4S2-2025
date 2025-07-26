
import 'package:flutter/material.dart';
import 'package:mad/screens/account_screen.dart';
import 'package:mad/screens/faculty_screen.dart';
import 'package:mad/screens/home_screen.dart';
import 'package:mad/screens/news_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      HomeScreen(),
      FacultyScreen(),
      NewsScreen(),
      AccountScreen()
    ];

    int _currentIndex = 0;

    final bottomNavItems = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.class_outlined), label: "Search"),
      BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "News"),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
    ];

    final bottomNav = BottomNavigationBar(
        currentIndex: _currentIndex,
        items: bottomNavItems,
        onTap: (int index) => {
          setState(() {
            _currentIndex = index;
          })
        },
    );

    return Scaffold(
      bottomNavigationBar: bottomNav,
      body: screens.elementAt(_currentIndex),
    );
  }
}
