import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mad/data/app_shared_pref.dart';
import 'package:mad/screens/login_screen.dart';
import 'package:mad/service/facebook_auth_service.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? _fullName;
  String? _email;

  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _currentUser();
  }

  Future<void> _currentUser() async {
    // final appSharedPref = AppSharedPref();
    // String? fullName = await appSharedPref.getSharedPrefByKey("fullName");
    // String? email = await appSharedPref.getSharedPrefByKey("email");

    final currentUser = await auth.currentUser;
    String? fullName = currentUser!.displayName;
    String? email = currentUser!.email;
    setState(() {
      _fullName = fullName;
      _email = email;
    });
  }

  Future<void> _logout() async {
    // final appSharedPref = AppSharedPref();
    // appSharedPref.logout();
    // await auth.signOut();
    await FacebookAuthService.instance.facebookSignOut();
    Get.offAll(LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text("Account", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0.5,

        actions: [Icon(Icons.edit, color: Colors.white)],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    title: Text("$_fullName"),
                    subtitle: Text("Full Name"),
                  ),
                  Divider(),
                  ListTile(title: Text("$_email"), subtitle: Text("Email")),
                  Divider(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    _logout();
                    final route = MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    );
                    Navigator.pushReplacement(context, route);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Logout", style: TextStyle(color: Colors.white)),
                      SizedBox(width: 8),
                      Icon(Icons.logout, color: Colors.white),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigoAccent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
