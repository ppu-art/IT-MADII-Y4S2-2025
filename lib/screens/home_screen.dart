import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  final searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {

      final searchField = Padding(padding: EdgeInsets.only(
          top: 16,
          left: 16, right: 16),
      child: TextField(
        controller: searchController,
        onChanged: (value){
            print("This is input : $value");
        },
        decoration: InputDecoration(
            hintText: "Search...",
            suffixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            )
        ),
      ),
      );

    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text("Hi, Guest", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          subtitle: Text("Here is your activity today."),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none))
        ],
      ),
      body: Column(
        children: [
          searchField
        ],
      ),
    );
  }
}
