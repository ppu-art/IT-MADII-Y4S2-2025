import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad/controller/favorite_controller.dart';
import 'package:mad/provider/favorite_provider.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    // final favoriteProvider = Provider.of<FavoriteProvider>(
    //   context,
    //   listen: true,
    // );

    final favoriteList = favoriteController.favorites;
    print("Favorite List : $favoriteList");
    List<Widget> favoriteItems = favoriteList.map((item) {
      Map<String, int> itemFavorite = item;
      print("Key : ${itemFavorite.keys}");
      print("Value : ${itemFavorite.values}");

      String image = itemFavorite.keys.map((it) => it).toList()[0];
      return Dismissible(
        key: ValueKey(image),
        onDismissed: (direction) {
          // favoriteProvider.removeFavorite(image);
          favoriteController.removeFavorite(image);
        },
        child: Column(
          children: [
            ListTile(
              leading: Image.asset("assets/images/$image"),
              title: Text("Architecture and Interior Design"),
              subtitle: Text("Transform spaces and inspire lifestyles"),
              onTap: () {},
            ),
            Divider(),
          ],
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.indigoAccent,
      ),
      body: ListView(children: favoriteItems),
    );
  }
}
