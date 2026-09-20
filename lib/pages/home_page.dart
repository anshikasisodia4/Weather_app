import 'package:flutter/material.dart';
import '../services/favorite_service.dart';
import '../services/weather_service.dart';
import '../widgets/weather_card.dart';
import '../widgets/favorite_card.dart';
import 'favorites_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cityController = TextEditingController();
  final WeatherService _weatherService = WeatherService();

  String city = 'Delhi';
  String temperature = '--°C';
  String condition = 'Search for a city';
  String humidity = '--%';
  String wind = '-- km/h';

  bool isLoading = false;
  String? errorMessage;

  Future<void> searchWeather() async {
    final searchCity = _cityController.text.trim();

    if (searchCity.isEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final data = await _weatherService.getWeather(searchCity);

      setState(() {
        city = data['city'];
        temperature = '${data['temperature']}°C';
        humidity = '${data['humidity']}%';
        wind = '${data['wind']} km/h';
        condition = getWeatherCondition(data['weatherCode']);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'City not found or weather unavailable';
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

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Breezy',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 3, 10, 16),
        foregroundColor: Colors.white,
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
            icon: const Icon(Icons.star),
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFF3F8FC),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: _cityController,
                onSubmitted: (_) => searchWeather(),
                decoration: InputDecoration(
                  hintText: 'Search city...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: searchWeather,
                    icon: const Icon(Icons.arrow_forward),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              if (isLoading)
                const CircularProgressIndicator()
              else if (errorMessage != null)
                Text(
                  errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                )
              else
                WeatherCard(
                  city: city,
                  temperature: temperature,
                  condition: condition,
                  humidity: humidity,
                  wind: wind,
                ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.star_border),
                  label: const Text('Add to Favorites'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF42A5F5),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Favorite Cities',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              
            ],
          ),
        ),
      ),
    );
  }
}