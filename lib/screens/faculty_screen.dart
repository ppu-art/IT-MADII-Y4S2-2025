import 'package:flutter/material.dart';
import 'package:mad/model/faculty.dart';
import 'package:mad/service/faculty_service.dart';

class FacultyScreen extends StatefulWidget {
  const FacultyScreen({super.key});

  @override
  State<FacultyScreen> createState() => _FacultyScreenState();
}

class _FacultyScreenState extends State<FacultyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text("Faculty", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: FacultyService.instance.loadFacultyList(),
        builder: (BuildContext context, AsyncSnapshot<List<Faculty>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Check Error
            if (snapshot.hasError) {
              return Center(child: Text("Error : ${snapshot.error}"));
            }

            // Check has Data
            if (!snapshot.hasData) {
              return Center(child: Text("No Data"));
            }

            List<Faculty> facultyList = snapshot.data!;

            return ListView.builder(
              itemCount: facultyList.length,
              itemBuilder: (BuildContext context, int index) {
                Faculty faculty = facultyList[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text("${faculty.name}"),
                      subtitle: Text("${faculty.nameKh}"),
                    ),
                    Divider(),
                  ],
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
