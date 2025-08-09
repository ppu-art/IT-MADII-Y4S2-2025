import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad/data/db_manager.dart';
import 'package:mad/data/file_storage.dart';
import 'package:mad/model/menu.dart';
import 'package:mad/provider/favorite_provider.dart';
import 'package:mad/screens/splash_screen.dart';
import 'package:mad/service/menu_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // File Storage
  // final fileStorage = FileStorage();
  // String data = await fileStorage.getDataFromFile();
  // print("Data Response From File 1 : $data");

  // fileStorage.writeDataToFile("Hi, PPUA");
  // data = await fileStorage.getDataFromFile();
  // print("Data Response From File 2: $data");

  // DB SQlite
  await DBManager.instance.database;

  List<String> menuItems = [
    "Faculty",
    "Subject",
    "Student",
    "Teacher",
    "Alumni",
  ];

  for (var item in menuItems) {
    Menu menu = Menu(title: item, description: item);
    await MenuService.instance.addMenu(menu);
  }

  final provider = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      //...
    ],
    child: App(),
  );

  runApp(provider);
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PPUA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
    );
  }
}
