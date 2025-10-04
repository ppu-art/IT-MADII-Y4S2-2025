import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mad/data/app_shared_pref.dart';
import 'package:mad/screens/login_screen.dart';
import 'package:mad/service/facebook_auth_service.dart';
import 'package:mad/service/firebase_auth_service.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? _fullName;
  String? _email;
  String? _profileUrl;

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
    String? profileUrl = currentUser.photoURL;
    setState(() {
      _fullName = fullName;
      _email = email;
      _profileUrl = profileUrl;
    });
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
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: CircleAvatar(
                      child: _profileUrl == null
                          ? Image.asset(
                              "assets/images/profile_default.png",
                              width: 500,
                              height: 500,
                            )
                          : Image.network(_profileUrl!),
                      radius: 30,
                      backgroundColor: Colors.indigoAccent,
                    ),
                  ),
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
                    FirebaseAuthService.instance.logout();
                    Get.offAll(LoginScreen());
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
