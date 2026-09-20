import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  Future<Map<String, dynamic>> getWeather(String city) async {
    final locationUrl = Uri.parse(
      'https://geocoding-api.open-meteo.com/v1/search'
      '?name=$city&count=1&language=en&format=json',
    );

    final locationResponse = await http.get(locationUrl);

    if (locationResponse.statusCode != 200) {
      throw Exception('Failed to find city');
    }

    final locationData = jsonDecode(locationResponse.body);

    if (locationData['results'] == null ||
        locationData['results'].isEmpty) {
      throw Exception('City not found');
    }

    final location = locationData['results'][0];

    final latitude = location['latitude'];
    final longitude = location['longitude'];
    final cityName = location['name'];

    final weatherUrl = Uri.parse(
      'https://api.open-meteo.com/v1/forecast'
      '?latitude=$latitude'
      '&longitude=$longitude'
      '&current=temperature_2m,relative_humidity_2m,wind_speed_10m,weather_code'
      '&temperature_unit=celsius'
      '&wind_speed_unit=kmh',
    );

    final weatherResponse = await http.get(weatherUrl);

    if (weatherResponse.statusCode != 200) {
      throw Exception('Failed to fetch weather');
    }

    final weatherData = jsonDecode(weatherResponse.body);

    return {
      'city': cityName,
      'temperature': weatherData['current']['temperature_2m'],
      'humidity': weatherData['current']['relative_humidity_2m'],
      'wind': weatherData['current']['wind_speed_10m'],
      'weatherCode': weatherData['current']['weather_code'],
    };
  }
}