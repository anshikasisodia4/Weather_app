import 'package:flutter/material.dart';

import '../services/favorite_service.dart';
import '../services/weather_service.dart';
import '../widgets/favorite_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteService favoriteService = FavoriteService();
    final WeatherService weatherService = WeatherService();

    return Scaffold(
      backgroundColor: const Color(0xFF020B20),

      appBar: AppBar(
        backgroundColor: const Color(0xFF020B20),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: StreamBuilder<List<String>>(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_off,
                    size: 80,
                    color: Color(0xFF64B5F6),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'No favorite cities yet',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add your favorite cities to see them here',
                    style: TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final city = favorites[index];

              return FavoriteCard(
                city: city,

                onDelete: () async {
                  await favoriteService.deleteFavorite(city);
                },

                onTap: () async {
          
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF42A5F5),
                        ),
                      );
                    },
                  );

                  try {
       
                    final weather =
                        await weatherService.getWeather(city);

                    if (context.mounted) {
                      Navigator.pop(context);
                    }

                    if (context.mounted) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: const Color(0xFF102A59),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: Text(
                              weather['city'].toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.thermostat,
                                  size: 60,
                                  color: Color(0xFF64B5F6),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  '${weather['temperature']}°C',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Current temperature',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Close',
                                  style: TextStyle(
                                    color: Color(0xFF64B5F6),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  } catch (e) {
   
                    if (context.mounted) {
                      Navigator.pop(context);
                    }

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Unable to get weather for $city',
                          ),
                        ),
                      );
                    }
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}