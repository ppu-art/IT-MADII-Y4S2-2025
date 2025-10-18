import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad/controller/firebase_firestore_db_controller.dart';
import 'package:mad/model/news.dart';

class AdminNewsScreen extends StatefulWidget {
  const AdminNewsScreen({super.key});

  @override
  State<AdminNewsScreen> createState() => _AdminNewsScreenState();
}

class _AdminNewsScreenState extends State<AdminNewsScreen> {
  bool _isLoading = true;
  List<News> newsList = [];
  final firebaseFirestoreDBController = FirebaseFirestoreDBController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await firebaseFirestoreDBController.getData(
      FirebaseFirestoreDBController.newsCollectionPath,
    );
    List<News> newsLists = data.map((e) => News.fromMap(e)).toList();
    print("Data : ${data}");
    setState(() {
      newsList = newsLists;
      _isLoading = false;
    });
  }

  Future<void> _handleDeletedData(String id) async {
    await firebaseFirestoreDBController.deleteData(
      FirebaseFirestoreDBController.newsCollectionPath,
      id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text("List News", style: TextStyle(color: Colors.white)),
        elevation: 5,
        centerTitle: true,
        actions: [
          GestureDetector(
            child: Icon(Icons.add),
            onTap: () {
              openButtonSheet();
            },
          ),
        ],
      ),
      body: _isLoading
          ? CircularProgressIndicator()
          : newsList.length == 0
          ? Center(child: Text("No Data"))
          : ListView.separated(
              itemCount: newsList.length,
              itemBuilder: (BuildContext context, int index) {
                final news = newsList[index];
                return Dismissible(
                  key: ValueKey(news.id),
                  onDismissed: (direction) {
                    _handleDeletedData(news.id!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${news.id} was deleted')),
                    );
                  },
                  child: ListTile(
                    leading: const Icon(Icons.star),
                    title: Text("${news.title!.substring(0, 30)}"),
                  ),
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

  void openButtonSheet() {
    final titleEditController = TextEditingController();
    final contentEditController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 500,
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                SizedBox(height: 16),
                TextField(
                  controller: titleEditController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      // 2. Optional: Customize the border radius (rounded corners)
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Enter title',
                    hintText: 'Input content',
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: contentEditController,
                  // Allows unlimited lines, making the field grow vertically
                  maxLines: null,
                  // Ensures the keyboard has a new line/return key
                  keyboardType: TextInputType.multiline,
                  // Optional: Sets the minimum initial height (e.g., 3 lines)
                  minLines: 5,
                  decoration: InputDecoration(
                    // 1. Set the main border to OutlineInputBorder
                    border: OutlineInputBorder(
                      // 2. Optional: Customize the border radius (rounded corners)
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Enter your text',
                    hintText: 'Input content',
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigoAccent,
                    ),
                    onPressed: () {
                      final title = titleEditController.text;
                      final content = contentEditController.text;
                      print("Title : $title");
                      print("Content : $content");
                      _saveData(title, content);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Insert",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _saveData(String title, String content) async {
    final dataReq = {"title": title, "content": content};
    await firebaseFirestoreDBController.createData(
      FirebaseFirestoreDBController.newsCollectionPath,
      dataReq,
    );
  }
}
