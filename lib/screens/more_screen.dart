import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad/screens/account_screen.dart';
import 'package:mad/screens/language_screen.dart';
import 'package:mad/screens/login_screen.dart';
import 'package:mad/screens/theme_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  String _fullName = "Guest";
  final auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    _getFullName();
  }

  Future<void> _getFullName() async {
    final User? currentUser = await auth.currentUser;
    setState(() {
      _fullName = currentUser!.displayName ?? currentUser!.email ?? "Guest";
    });
  }

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
            subtitle: Text("$_fullName"),
            onTap: () {
              _checkNavigateToAccount();
            },
          ),
          Divider(),
        ],
      ),
    );
  }

  void _checkNavigateToAccount() async {
    final User? currentUser = await auth.currentUser;
    if (currentUser == null) {
      final route = MaterialPageRoute(builder: (context) => LoginScreen());
      Navigator.pushReplacement(context, route);
    }
    final route = MaterialPageRoute(builder: (context) => AccountScreen());
    Navigator.pushReplacement(context, route);
  }
}
