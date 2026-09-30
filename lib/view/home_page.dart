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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Search for a city first'),
        ),
      );
      return;
    }

    if (isAddingFavorite) return;

    setState(() {
      isAddingFavorite = true;
    });

    try {
      await _favoriteService.addFavorite(city);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$city added to favorites'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not add city to favorites'),
          ),
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
            icon: const Icon(
              Icons.favorite_border,
              color: Color(0xFF64B5F6),
            ),
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
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 14),

            SearchBarWidget(
              controller: _cityController,
              onSearch: searchWeather,
            ),

            const SizedBox(height: 28),

            if (isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: CircularProgressIndicator(
                    color: Color(0xFF42A5F5),
                  ),
                ),
              )
            else if (errorMessage != null)
              Center(
                child: Text(
                  errorMessage!,
                  style: const TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
              )
            else if (city.isNotEmpty)
              WeatherCard(
                city: city,
                temperature: temperature,
                condition: condition,
                humidity: humidity,
                wind: wind,
                weatherCode: weatherCode,
              )
            else
              const EmptyWeather(),

            const SizedBox(height: 22),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed:
                    isAddingFavorite ? null : addToFavorites,
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
                  isAddingFavorite
                      ? 'Adding...'
                      : 'Add to Favorites',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF42A5F5),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor:
                      const Color(0xFF21477F),
                  padding: const EdgeInsets.symmetric(
                    vertical: 17,
                  ),
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

            FavoriteSection(
              favoriteService: _favoriteService,
            ),
          ],
        ),
      ),
    );
  }
}