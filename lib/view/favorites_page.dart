import 'package:flutter/material.dart';
import '../controllers/favorite_controller.dart';
import '../models/favorite_model.dart';
import '../widgets/favorite_card.dart';

class FavoritesPage extends StatelessWidget {
  final Function(String) onCitySelected;

  const FavoritesPage({
    super.key,
    required this.onCitySelected,
  });

  @override
  Widget build(BuildContext context) {
    final FavoriteController favoriteController =
        FavoriteController();

    return Scaffold(
      backgroundColor: const Color(0xFF020B20),

      appBar: AppBar(
        backgroundColor: const Color(0xFF020B20),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: StreamBuilder<List<FavoriteModel>>(
        stream: favoriteController.getFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF42A5F5),
              ),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Unable to load favorites',
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
            );
          }

          final favorites = snapshot.data ?? [];

          if (favorites.isEmpty) {
            return const Center(
              child: Text(
                'No favorite cities yet',
                style: TextStyle(
                  color: Colors.white54,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favorite = favorites[index];

              return FavoriteCard(
                city: favorite.city,

                onDelete: () async {
                  await favoriteController.deleteFavorite(
                    favorite.city,
                  );
                },

                onTap: () {
                  onCitySelected(favorite.city);
                },
              );
            },
          );
        },
      ),
    );
  }
}