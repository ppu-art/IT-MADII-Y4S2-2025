import 'package:flutter/material.dart';
import 'package:mad/data/app_shared_pref.dart';
import 'package:mad/model/menu.dart';
import 'package:mad/service/menu_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  String _fullName = "Guest";
  List<Menu> _menuList = [];

  @override
  void initState() {
    super.initState();
    _getFullName();
    _getAllMenus();
  }

  Future<void> _getFullName() async {
    final fullName = await AppSharedPref().getFullName();
    setState(() {
      _fullName = fullName!;
    });
  }

  Future<void> _getAllMenus() async {
    List<Menu> menuList = await MenuService.instance.getAllMenus();
    setState(() {
      _menuList = menuList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchField = Padding(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          print("This is input : $value");
        },
        decoration: InputDecoration(
          hintText: "Search...",
          suffixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );

    final _slide = Padding(
      padding: EdgeInsets.only(top: 16, left: 8, right: 8),
      child: Image.asset(
        "assets/images/slide.png",
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text(
            "Hi, $_fullName",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          subtitle: Text("Here is your activity today."),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none)),
        ],
      ),
      body: Column(
        children: [
          searchField,
          _slide,
          _menuTitleRowWidget,
          _menuListRowWidget,
        ],
      ),
    );
  }

  Widget get _menuTitleRowWidget => Padding(
    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("មុឺនុយ"),
        Row(children: [Text("ទាំងអស់"), Icon(Icons.navigate_next)]),
      ],
    ),
  );

  Widget get _menuListRowWidget {
    List<Widget> menuItems = _menuList.map((menu) {
      return Padding(
        padding: EdgeInsets.only(right: 16),

        child: Column(
          children: [
            Image.asset("assets/images/faculty.png"),
            Text("${menu.title}"),
          ],
        ),
      );
    }).toList();

    return Padding(
      padding: EdgeInsets.only(left: 16, top: 16),
      child: Row(children: menuItems),
    );
  }
}
