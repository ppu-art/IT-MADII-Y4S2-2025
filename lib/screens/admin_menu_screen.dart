import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:mad/controller/firebase_realtime_db_controller.dart';
import 'package:mad/model/menu.dart';

class AdminMenuScreen extends StatefulWidget {
  const AdminMenuScreen({super.key});

  @override
  State<AdminMenuScreen> createState() => _AdminMenuScreenState();
}

class _AdminMenuScreenState extends State<AdminMenuScreen> {
  final firebaseRealtimeDBController = Get.put(FirebaseRealtimeDBController());

  bool _isLoading = true;
  List<Menu> menuList = [];

  Future<void> _getAllMenus() async {
    List<Menu> menuListItems = [];
    await firebaseRealtimeDBController
        .getRealtimeDB(FirebaseRealtimeDBController.menuRefId)
        .then((data) {
          print("Data : $data");
          data.forEach((key, value) {
            print("Key : $key");
            print("Value : $value");
            final menu = Menu(title: value["title"]);
            menuListItems.add(menu);
          });
          setState(() {
            _isLoading = false;
            menuList = menuListItems;
          });
        })
        .catchError((error) {
          setState(() {
            _isLoading = false;
          });
        });
  }

  Future<void> _createMenu(String title, String description) async {
    // Post Data
    final Map<String, Object> dataReq = {
      "title": title,
      "description": description,
    };
    firebaseRealtimeDBController.createRealtimeDB(
      FirebaseRealtimeDBController.menuRefId,
      dataReq,
    );
  }

  @override
  void initState() {
    super.initState();
    _getAllMenus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
        title: Text("Menu List", style: TextStyle(color: Colors.white)),
        actions: [
          GestureDetector(
            child: Icon(Icons.add, color: Colors.white),
            onTap: () {
              _handleCreateMenu();
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : menuList.length == 0
          ? Center(child: Text("No Data"))
          : ListView.separated(
              itemCount: menuList.length,
              itemBuilder: (BuildContext context, int index) {
                Menu menuItem = menuList[index];
                return ListTile(
                  title: Text("${menuItem.title}"),
                  subtitle: Text("${menuItem.title}"),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  color: Colors.grey,
                  height: 1,
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                );
              },
            ),
    );
  }

  void _handleCreateMenu() {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    final alertDialog = AlertDialog(
      title: Text("Create Menu"),
      content: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: "Title"),
            controller: titleController,
          ),
          TextField(
            decoration: InputDecoration(labelText: "Description"),
            controller: descriptionController,
          ),
          ElevatedButton(
            onPressed: () {
              _createMenu(titleController.text, descriptionController.text);
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }
}
