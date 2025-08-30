import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mad/model/faculty.dart';

class FacultyService {
  static FacultyService _instance = FacultyService._init();

  static FacultyService get instance => _instance;

  FacultyService._init();

  Future<List<Faculty>> loadFacultyList() async {
    String apiUrl = "http://10.0.2.2:8080/api/v1/faculty";

    final header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    final res = await http.get(Uri.parse(apiUrl), headers: header);

    // final dio = Dio();
    // Response res2 = await dio.get(apiUrl, options: Options(headers: header));

    if (res.statusCode == 200) {
      // final data = res.data as List<dynamic>;
      // print("Data $data");
      // List<Faculty> faculties = [];
      // data.forEach((item) {
      //   print("item $item");
      //   faculties.add(Faculty.fromMap(item));
      // });

      final data = jsonDecode(res.body) as List<dynamic>;
      print("Data : $data");
      List<Faculty> faculties = data
          .map((item) => Faculty.fromMap(item))
          .toList();
      print("Faculty List : ${faculties.length}");
      return faculties;
    } else {
      print("Error : ${res.statusCode}");
      throw ("Error : ${res.statusCode}");
    }
  }
}
