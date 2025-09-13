import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad/controller/favorite_controller.dart';
import 'package:mad/data/app_shared_pref.dart';
import 'package:mad/model/faculty.dart';
import 'package:mad/model/menu.dart';
import 'package:mad/provider/favorite_provider.dart';
import 'package:mad/screens/faculty_detail_screen.dart';
import 'package:mad/screens/favorite_screen.dart';
import 'package:mad/service/faculty_service.dart';
import 'package:mad/service/menu_service.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  String _fullName = "Guest";
  List<Menu> _menuList = [];
  int _totalFavorite = 0;

  final favoriteController = Get.put(FavoriteController());

  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _getFullName();
    _getAllMenus();
  }

  Future<void> _getFullName() async {
    //final fullName = await AppSharedPref().getFullName();
    final User? currentUser = await auth.currentUser;
    setState(() {
      _fullName = currentUser!.displayName ?? currentUser!.email ?? "Guest";
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
    // final favoriteProvider = Provider.of<FavoriteProvider>(
    //   context,
    //   listen: true,
    // );
    List<Map<String, int>> favoriteList = favoriteController.favorites;
    setState(() {
      _totalFavorite = favoriteList.length;
    });

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

    List<String> designList = List.generate(3, (i) => "design${i + 1}.jpg");
    print("Design List : $designList");

    List<Widget> menuItems = designList.map((item) {
      final imageItem = "assets/images/$item";

      return GestureDetector(
        child: Padding(
          padding: EdgeInsets.only(right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset("$imageItem", height: 200, width: 200),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Icon(Icons.favorite),
                    onTap: () {
                      // favoriteProvider.addFavorite(item);
                      favoriteController.addFavorite(item);
                    },
                  ),
                ],
              ),
              Text(
                "${"Architecture and Interior Design".substring(0, 25)}...",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                "${"Transform spaces and inspire lifestyles in the Architecture and Interior Design major. Master the art of designing functional and beautiful environments, blending aesthetics with practicality. Build a career that shapes the world around us.".substring(0, 25)}...",
              ),
            ],
          ),
        ),
        onTap: () {
          Get.to(FacultyDetailScreen(), arguments: imageItem);
        },
      );
    }).toList();

    final rowItems = Padding(
      padding: EdgeInsets.only(left: 8),
      child: Row(children: menuItems),
    );

    final _designListRowWidget = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: rowItems,
    );

    String welcome = "hi".tr + " $_fullName";

    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text(
            "$welcome",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          subtitle: Text("Here is your activity today."),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // final route = MaterialPageRoute(
              //   builder: (context) => FavoriteScreen(),
              // );
              // Navigator.push(context, route);
              Get.to(FavoriteScreen());
            },
            icon: badges.Badge(
              badgeContent: Obx(
                () => Text(
                  "${favoriteController.favorites.length}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              position: badges.BadgePosition.topEnd(top: 0, end: 3),
              child: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          searchField,
          _slide,
          _menuTitleRowWidget,
          _menuListRowWidget,
          _designTitleRowWidget,
          _designListRowWidget,
          _itTitleRowWidget,
          _itListRowWidget,
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

    // Option1
    // return Padding(
    //   padding: EdgeInsets.only(left: 16, top: 16),
    //   child: SingleChildScrollView(
    //     scrollDirection: Axis.horizontal,
    //     child: Row(children: menuItems),
    //   ),
    // );

    // Option2
    return Padding(
      padding: EdgeInsets.only(left: 16, top: 16),
      child: SizedBox(
        height: 100,
        child: ListView(scrollDirection: Axis.horizontal, children: menuItems),
      ),
    );
  }

  Widget get _designTitleRowWidget => Padding(
    padding: EdgeInsets.only(left: 8, right: 8, top: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Design"),
        Row(children: [Text("See All"), Icon(Icons.navigate_next)]),
      ],
    ),
  );

  Widget get _itTitleRowWidget => Padding(
    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("IT"),
        Row(children: [Text("See All"), Icon(Icons.navigate_next)]),
      ],
    ),
  );

  Widget get _itListRowWidget {
    List<String> designList = List.generate(3, (i) => "it${i + 1}.jpg");
    print("IT List : $designList");
    List<Widget> menuItems = designList.map((item) {
      return GestureDetector(
        child: Padding(
          padding: EdgeInsets.only(right: 8),
          child: Image.asset("assets/images/$item", height: 200, width: 200),
        ),
        onTap: () {
          favoriteController.addFavorite(item);
        },
      );
    }).toList();

    final rowItems = Padding(
      padding: EdgeInsets.only(left: 8),
      child: Row(children: menuItems),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: rowItems,
    );
  }
}
