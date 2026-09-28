import 'package:flutter/material.dart';
import '../services/favorite_service.dart';
import 'favorite_card.dart';

class FavoriteSection extends StatelessWidget {
  final FavoriteService favoriteService;

  const FavoriteSection({
    super.key,
    required this.favoriteService,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
      stream: favoriteService.getFavorites(),
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
            style: TextStyle(color: Colors.redAccent),
          );
        }

        final favorites = snapshot.data ?? [];

        if (favorites.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'No favorite cities yet',
              style: TextStyle(color: Colors.white54),
            ),
          );
        }

        return Column(
          children: favorites.take(7).map((city) {
            return FavoriteCard(
              city: city,
              onDelete: () async {
                await favoriteService.deleteFavorite(city);
              },
              onTap: () {},
            );
          }).toList(),
        );
      },
    );
  }
}