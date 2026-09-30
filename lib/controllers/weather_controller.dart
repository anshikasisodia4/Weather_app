import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherController {
  final WeatherService weatherService;

  WeatherController(this.weatherService);

  WeatherModel? weather;
  bool isLoading = false;
  String? error;

  Future<void> fetchWeather(String city) async {
    isLoading = true;
    error = null;

    try {
      weather = await weatherService.getWeather(city);
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
  }
}