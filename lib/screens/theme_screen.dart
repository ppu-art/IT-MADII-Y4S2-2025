import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  bool _isLight = true;

  @override
  void initState() {
    super.initState();
    _getCurrentTheme();
  }

  Future<void> _getCurrentTheme() async {
    setState(() {
      _isLight = !Get.isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "theme".tr,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
      ),
      body: ListView(
        children: [
          ListTile(
            trailing: Checkbox(
              value: _isLight,
              onChanged: (value) {
                Get.changeTheme(ThemeData.light());
                setState(() {
                  _isLight = true;
                });
              },
            ),
            title: Text("light".tr),
            subtitle: Text("themeLight".tr),
            leading: Icon(Icons.light_mode),
          ),
          Divider(),
          ListTile(
            trailing: Checkbox(
              value: !_isLight,
              onChanged: (value) {
                Get.changeTheme(ThemeData.dark());
                setState(() {
                  _isLight = false;
                });
              },
            ),
            title: Text("dark".tr),
            subtitle: Text("themeDark".tr),
            leading: Icon(Icons.dark_mode),
          ),
          Divider(),
        ],
      ),
    );
  }
}
