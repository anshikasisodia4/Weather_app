import 'package:flutter/material.dart';
import '../controllers/favorite_controller.dart';
import 'favorite_card.dart';

class FavoriteSection extends StatelessWidget {
  final FavoriteController favoriteController;
  final Function(String) onCitySelected;

  const FavoriteSection({
    super.key,
    required this.favoriteController,
    required this.onCitySelected,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: favoriteController.getFavorites(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF42A5F5),
            ),
          );
        }

        if (snapshot.hasError) {
          return const Text(
            'Unable to load favorites',
            style: TextStyle(
              color: Colors.redAccent,
            ),
          );
        }

        final favorites = snapshot.data ?? [];

        if (favorites.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'No favorite cities yet',
              style: TextStyle(
                color: Colors.white54,
              ),
            ),
          );
        }

        return Column(
          children: favorites.take(7).map((favorite) {
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
          }).toList(),
        );
      },
    );
  }
}