import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mad/model/faculty.dart';

class FacultyService {
  static FacultyService _instance = FacultyService._init();

  static FacultyService get instance => _instance;

  FacultyService._init();

  Future<List<Faculty>> loadFacultyList() async {
    String apiUrl = "http://10.0.2.2/ppua/faculty.php";
    final header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    //final res = await http.get(Uri.parse(apiUrl), headers: header);

    final dio = Dio();
    Response res2 = await dio.get(apiUrl, options: Options(headers: header));
    if (res2.statusCode == 200) {
      final data = res2.data as List<dynamic>;
      print("Data $data");
      List<Faculty> faculties = [];
      data.forEach((item) {
        print("item $item");
        faculties.add(Faculty.fromMap(item));
      });

      // print("Data $data");
      // List<Faculty> faculties = data
      //     .map((item) => Faculty.fromMap(item))
      //     .toList();
      // print("Faculty List : ${faculties.length}");
      return faculties;
    } else {
      print("Error : ${res2.statusCode}");
      throw ("Error : ${res2.statusCode}");
    }
  }
}
