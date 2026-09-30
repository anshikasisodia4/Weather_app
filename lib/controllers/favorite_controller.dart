import 'package:flutter/foundation.dart';
import '../services/favorite_service.dart';

class FavoriteController extends ChangeNotifier {
  final FavoriteService _favoriteService = FavoriteService();

  bool isAddingFavorite = false;
  String? errorMessage;

  Future<void> addFavorite(String city) async {
    if (city.trim().isEmpty) return;

    isAddingFavorite = true;
    errorMessage = null;
    notifyListeners();

    try {
      await _favoriteService.addFavorite(city);
    } catch (e) {
      errorMessage = 'Could not add city to favorites';
    }

    isAddingFavorite = false;
    notifyListeners();
  }

  Future<void> deleteFavorite(String city) async {
    try {
      await _favoriteService.deleteFavorite(city);
      notifyListeners();
    } catch (e) {
      errorMessage = 'Could not delete city from favorites';
      notifyListeners();
    }
  }

  Stream<List<String>> getFavorites() {
    return _favoriteService.getFavorites();
  }
}