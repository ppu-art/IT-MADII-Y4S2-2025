import 'package:flutter/material.dart';
import 'package:mad/data/file_storage.dart';
import 'package:mad/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final fileStorage = FileStorage();
  String data = await fileStorage.getDataFromFile();
  print("Data Response From File 1 : $data");

  fileStorage.writeDataToFile("Hi, PPUA");
  data = await fileStorage.getDataFromFile();
  print("Data Response From File 2: $data");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PPUA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
    );
  }
}
