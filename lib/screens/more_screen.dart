import 'package:flutter/material.dart';
import 'package:mad/screens/login_screen.dart';

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
        title: Text("More", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
      ),
      body: Column(
        children: [
          ListTile(title: Text("Language"), subtitle: Text("English")),
          Divider(),
          ListTile(title: Text("Theme"), subtitle: Text("Light")),
          Divider(),
          ListTile(
            title: Text("Profile"),
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
