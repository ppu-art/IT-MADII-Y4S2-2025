// import 'package:mad/data/db_manager.dart';
// import 'package:mad/model/menu.dart';

import 'package:mad/model/menu.dart';

class MenuService {
  final String tableName = "tb_menu";

  static final MenuService instance = MenuService._init();

  MenuService._init();

  Future<List<Menu>> getAllMenus() async {
    try {
      // final db = await DBManager.instance.database;
      // final List<Map<String, dynamic>> maps = await db.query(tableName);
      // return List.generate(maps.length, (i) {
      //   return Menu.fromMap(maps[i]);
      // });

      return [];
    } catch (error) {
      print("Error : $error");
      return [];
    }
  }

  Future<void> addMenu(Menu menu) async {
    try {
      // final db = await DBManager.instance.database;
      // await db.insert(tableName, menu.toMap());
    } catch (error) {
      print("Error $error");
    }
  }
}
