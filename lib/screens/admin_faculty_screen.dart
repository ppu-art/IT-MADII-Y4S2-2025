import 'package:flutter/material.dart';
import 'package:mad/model/faculty.dart';
import 'package:mad/controller/firebase_firestore_db_controller.dart';

class AdminFacultyScreen extends StatefulWidget {
  const AdminFacultyScreen({super.key});

  @override
  State<AdminFacultyScreen> createState() => _AdminFacultyScreenState();
}

class _AdminFacultyScreenState extends State<AdminFacultyScreen> {
  final firestoreController = FirebaseFirestoreDBController();
  List<Faculty> facultyList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await firestoreController.getData(
      FirebaseFirestoreDBController.facultyCollectionPath,
    );
    List<Faculty> facultyLists = data.map((e) => Faculty.fromMap(e)).toList();
    print("Data : $facultyLists");
    setState(() {
      facultyList = facultyLists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
        title: Text("Faculty", style: TextStyle(color: Colors.white)),
        actions: [
          GestureDetector(
            child: Icon(Icons.add, color: Colors.white),
            onTap: () {
              createMenuButtonSheet();
            },
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: facultyList.length,
        itemBuilder: (BuildContext context, int index) {
          final faculty = facultyList[index];
          return ListTile(
            leading: Icon(Icons.book),
            title: Text("${faculty.nameKh}"),
            subtitle: Text("${faculty.name}"),
            trailing: Icon(Icons.navigate_next),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }

  void createMenuButtonSheet() {
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
                    labelText: 'Enter name khmer',
                    hintText: 'Input name khmer',
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
                    labelText: 'Enter name english',
                    hintText: 'Input name english',
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
                      final nameKh = titleEditController.text;
                      final nameEn = contentEditController.text;
                      _saveData(nameKh, nameEn);
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

  Future<void> _saveData(String nameKh, String nameEn) async {
    final dataReq = {'nameKh': nameKh, 'nameEn': nameEn};
    await firestoreController.createData(
      FirebaseFirestoreDBController.facultyCollectionPath,
      dataReq,
    );
  }
}
