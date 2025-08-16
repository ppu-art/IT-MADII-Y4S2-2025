import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad/screens/language_screen.dart';
import 'package:mad/screens/login_screen.dart';
import 'package:mad/screens/theme_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("more".tr, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("language".tr),
            subtitle: Text(
              "${Get.locale!.languageCode == "en" ? "english".tr : "khmer".tr}",
            ),
            onTap: () {
              // Option 1
              // final route = MaterialPageRoute(
              //   builder: (context) => LanguageScreen(),
              // );
              // Navigator.push(context, route);

              // Option2
              Get.to(LanguageScreen());
            },
          ),
          Divider(),
          ListTile(
            title: Text("theme".tr),
            subtitle: Text("light".tr),
            onTap: () {
              Get.to(ThemeScreen());
            },
          ),
          Divider(),
          ListTile(
            title: Text("profile".tr),
            subtitle: Text("Guest"),
            onTap: () {
              final route = MaterialPageRoute(
                builder: (context) => LoginScreen(),
              );
              Navigator.pushReplacement(context, route);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
