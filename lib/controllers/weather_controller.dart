import 'package:flutter/foundation.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';

class WeatherController extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();

  WeatherModel? weather;

  bool isLoading = false;
  String? errorMessage;

  Future<void> searchWeather(String city) async {
    final searchCity = city.trim();

    if (searchCity.isEmpty) return;

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      weather = await _weatherService.getWeather(searchCity);
    } catch (e) {
      weather = null;
      errorMessage = 'City not found or currently unavailable';
    }

    isLoading = false;
    notifyListeners();
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
}