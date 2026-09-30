import 'package:flutter/material.dart';

import '../controllers/weather_controller.dart';
import '../services/favorite_service.dart';
import '../widgets/weather_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/empty_weather.dart';
import '../widgets/favorite_section.dart';
import 'favorites_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cityController = TextEditingController();

  final WeatherController _weatherController = WeatherController();

  final FavoriteService _favoriteService = FavoriteService();

  bool isAddingFavorite = false;

  Future<void> addToFavorites() async {
    final city = _weatherController.weather?.city;

    if (city == null || city.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Search for a city first')));
      return;
    }

    if (isAddingFavorite) return;

    setState(() {
      isAddingFavorite = true;
    });

    try {
      await _favoriteService.addFavorite(city);

      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$city added to favorites')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not add city to favorites')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isAddingFavorite = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _cityController.dispose();
    _weatherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _weatherController,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF020B20),

          appBar: AppBar(
            backgroundColor: const Color(0xFF020B20),
            elevation: 0,
            title: const Text(
              'Breezy',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoritesPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.star_border, color: Color(0xFF64B5F6)),
              ),
            ],
          ),

          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Find your weather',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),

                const SizedBox(height: 14),

                SearchBarWidget(
                  controller: _cityController,
                  onSearch: () {
                    _weatherController.searchWeather(_cityController.text);
                  },
                ),

                const SizedBox(height: 28),

                if (_weatherController.isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: CircularProgressIndicator(
                        color: Color(0xFF42A5F5),
                      ),
                    ),
                  )
                else if (_weatherController.errorMessage != null)
                  Center(
                    child: Text(
                      _weatherController.errorMessage!,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  )
                else if (_weatherController.weather != null)
                  WeatherCard(
                    city: _weatherController.weather!.city,
                    temperature: '${_weatherController.weather!.temperature}°',
                    condition: _weatherController.getWeatherCondition(
                      _weatherController.weather!.weatherCode,
                    ),
                    humidity: '${_weatherController.weather!.humidity}%',
                    wind: '${_weatherController.weather!.windSpeed} km/h',
                    weatherCode: _weatherController.weather!.weatherCode,
                  )
                else
                  const EmptyWeather(),

                const SizedBox(height: 22),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: isAddingFavorite ? null : addToFavorites,
                    icon: isAddingFavorite
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.star),
                    label: Text(
                      isAddingFavorite ? 'Adding...' : 'Add to Favorites',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF42A5F5),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: const Color(0xFF21477F),
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  'Favorite Cities',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 14),

                FavoriteSection(favoriteService: _favoriteService),
              ],
            ),
          ),
        );
      },
    );
  }
}
