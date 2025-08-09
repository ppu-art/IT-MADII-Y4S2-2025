import 'package:get/get.dart';

class FavoriteController extends GetxController {
  RxList<Map<String, int>> _favorites = <Map<String, int>>[].obs;
  List<Map<String, int>> get favorites => _favorites;

  void addFavorite(String id) {
    final newFavorite = {id: 0};
    final favorite = _favorites.firstWhere(
      (element) => element.containsKey(id),
      orElse: () => newFavorite,
    );
    // Add new value
    favorite.update(id, (value) => value + 1);
    // Remove Old
    _favorites.removeWhere((element) => element.containsKey(id));
    // Add New with updated value
    _favorites.add(favorite);
    print("_favorites ${_favorites}");
    _favorites.refresh();
  }

  void removeFavorite(String id) {
    _favorites.removeWhere((element) => element.containsKey(id));
    _favorites.refresh();
  }
}
