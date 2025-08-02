import 'package:flutter/material.dart';
import 'package:mad/screens/account_screen.dart';
import 'package:mad/screens/faculty_screen.dart';
import 'package:mad/screens/home_screen.dart';
import 'package:mad/screens/more_screen.dart';
import 'package:mad/screens/news_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List screens = [HomeScreen(), FacultyScreen(), NewsScreen(), MoreScreen()];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bottomNavItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Home",
        backgroundColor: Colors.indigoAccent,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.class_outlined),
        label: "Faculty",
        backgroundColor: Colors.indigoAccent,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.newspaper),
        label: "News",
        backgroundColor: Colors.indigoAccent,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.more_vert),
        label: "More",
        backgroundColor: Colors.indigoAccent,
      ),
    ];

    final bottomNav = BottomNavigationBar(
      currentIndex: currentIndex,
      items: bottomNavItems,
      selectedItemColor: Colors.red,
      selectedFontSize: 16,
      onTap: (int index) {
        print("Index $index");
        setState(() {
          currentIndex = index;
        });
      },
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );

    return Scaffold(
      bottomNavigationBar: bottomNav,
      body: screens[currentIndex],
    );
  }
}
