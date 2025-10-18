import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad/screens/admin_faculty_screen.dart';
import 'package:mad/screens/admin_menu_screen.dart';
import 'package:mad/screens/admin_news_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text("Admin Dashboard", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: Text("Admin"),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: Text("Welcome to Admin")),
            ListTile(title: Text("Users"), subtitle: Text("List Users")),
            Divider(),
            ListTile(
              title: Text("Menu"),
              subtitle: Text("List Menu"),
              onTap: () {
                Get.to(AdminMenuScreen());
              },
            ),
            Divider(),
            ListTile(
              title: Text("Faculty"),
              subtitle: Text("List Faculty"),
              onTap: () {
                Get.to(AdminFacultyScreen());
              },
            ),
            Divider(),
            ListTile(
              title: Text("News"),
              subtitle: Text("List News"),
              onTap: () {
                Get.to(AdminNewsScreen());
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
