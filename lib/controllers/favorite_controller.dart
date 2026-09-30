import '../services/favorite_service.dart';

class FavoriteController {
  final FavoriteService _favoriteService = FavoriteService();

  Stream<List<String>> getFavorites() {
    return _favoriteService.getFavorites();
  }

  Future<void> addFavorite(String city) async {
    await _favoriteService.addFavorite(city);
  }

  Future<void> deleteFavorite(String city) async {
    await _favoriteService.deleteFavorite(city);
  }
}