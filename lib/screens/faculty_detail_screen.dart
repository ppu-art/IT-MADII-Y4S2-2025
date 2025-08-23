import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class FacultyDetailScreen extends StatefulWidget {
  const FacultyDetailScreen({super.key});

  @override
  State<FacultyDetailScreen> createState() => _FacultyDetailScreenState();
}

class _FacultyDetailScreenState extends State<FacultyDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final imageItem = Get.arguments;
    print("ImageItem $imageItem");

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
        actions: [
          IconButton(
            onPressed: () {
              _loadImage("PPUA_Software Engineering.png");
            },
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: Column(children: [Image.asset(imageItem)]),
    );
  }

  Future<void> _loadImage(String filename) async {
    String apiUrl =
        "https://ppua.edu.kh/wp-content/uploads/2024/07/8qeb0fte9vw-1024x683.jpg";
    final dio = Dio();
    final dir = await getApplicationDocumentsDirectory();
    final filePath = "${dir.path}/$filename";
    try {
      await dio.download(
        apiUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print(
              "Downloading: ${(received / total * 100).toStringAsFixed(0)}%",
            );
          }
        },
      );
      print("Download saved to: $filePath");
    } catch (e) {
      print("Download error: $e");
    }
  }
}
