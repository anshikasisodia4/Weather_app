import 'package:flutter/material.dart';
import '../services/weather_service.dart';
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

  final WeatherService _weatherService = WeatherService();
  final FavoriteService _favoriteService = FavoriteService();

  String city = '';
  String temperature = '--°';
  String condition = 'Search a city';
  String humidity = '--%';
  String wind = '-- km/h';

  int weatherCode = 0;

  bool isLoading = false;
  bool isAddingFavorite = false;

  String? errorMessage;

  Future<void> searchWeather() async {
    final searchCity = _cityController.text.trim();

    if (searchCity.isEmpty) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final data = await _weatherService.getWeather(searchCity);

      setState(() {
        city = data.city;
        temperature = '${data.temperature}°';
        humidity = '${data.humidity}%';
        wind = '${data.windSpeed} km/h';
        weatherCode = data.weatherCode;
        condition = getWeatherCondition(data.weatherCode);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'City not found or currently unavailable';
        isLoading = false;
      });
    }
  }

  String getWeatherCondition(int code) {
    if (code == 0) {
      return 'Clear Sky';
    } else if (code <= 3) {
      return 'Partly Cloudy';
    } else if (code <= 48) {
      return 'Foggy';
    } else if (code <= 57) {
      return 'Drizzle';
    } else if (code <= 67) {
      return 'Rainy';
    } else if (code <= 77) {
      return 'Snowy';
    } else if (code <= 82) {
      return 'Rain Showers';
    } else if (code <= 86) {
      return 'Snow Showers';
    } else {
      return 'Thunderstorm';
    }
  }

  Future<void> addToFavorites() async {
    if (city.isEmpty) {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08152F),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        'Breezy',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      SizedBox(height: 3),

                      Text(
                        'Weather forecast',
                        style: TextStyle(color: Colors.white54, fontSize: 13),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FavoritesPage(),
                        ),
                      );
                    },

                    icon: const Icon(
                      Icons.favorite_border_rounded,
                      color: Colors.white,
                      size: 27,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              SearchBarWidget(
                controller: _cityController,
                onSearch: searchWeather,
              ),

              const SizedBox(height: 28),

              if (isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(60),

                    child: CircularProgressIndicator(color: Color(0xFF64B5F6)),
                  ),
                )
              else if (errorMessage != null)
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(25),

                  decoration: BoxDecoration(
                    color: Colors.white.withValues(),
                    borderRadius: BorderRadius.circular(28),
                  ),

                  child: Column(
                    children: [
                      const Icon(
                        Icons.cloud_off_rounded,
                        color: Colors.white54,
                        size: 45,
                      ),

                      const SizedBox(height: 12),

                      Text(
                        errorMessage!,
                        textAlign: TextAlign.center,

                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                )
              else if (city.isNotEmpty)
                Column(
                  children: [
                    WeatherCard(
                      city: city,
                      temperature: temperature,
                      condition: condition,
                      humidity: humidity,
                      wind: wind,
                      weatherCode: weatherCode,
                    ),

                    const SizedBox(height: 18),

                    GestureDetector(
                      onTap: isAddingFavorite ? null : addToFavorites,

                      child: Container(
                        width: double.infinity,

                        padding: const EdgeInsets.symmetric(vertical: 16),

                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF387BEA), Color(0xFF5B5FEF)],
                          ),

                          borderRadius: BorderRadius.circular(18),
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            if (isAddingFavorite)
                              const SizedBox(
                                width: 19,
                                height: 19,

                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            else
                              const Icon(
                                Icons.favorite_border_rounded,
                                color: Colors.white,
                                size: 20,
                              ),

                            const SizedBox(width: 9),

                            Text(
                              isAddingFavorite
                                  ? 'Adding...'
                                  : 'Add to Favorites',

                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              else
                const EmptyWeather(),

              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  const Text(
                    'Favorite Cities',

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FavoritesPage(),
                        ),
                      );
                    },

                    child: const Text(
                      'See all',

                      style: TextStyle(color: Color(0xFF64B5F6)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),
              FavoriteSection(favoriteService: _favoriteService),
            ],
          ),
        ),
      ),
    );
  }
}
