import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String city;
  final String temperature;
  final String condition;
  final String humidity;
  final String wind;
  final int weatherCode;

  const WeatherCard({
    super.key,
    required this.city,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.wind,
    required this.weatherCode,
  });

  IconData get weatherIcon {
    if (weatherCode == 0) {
      return Icons.wb_sunny;
    } else if (weatherCode <= 3) {
      return Icons.cloud;
    } else if (weatherCode <= 48) {
      return Icons.cloud;
    } else if (weatherCode <= 67) {
      return Icons.water_drop;
    } else if (weatherCode <= 77) {
      return Icons.ac_unit;
    } else if (weatherCode <= 82) {
      return Icons.water_drop;
    } else if (weatherCode <= 86) {
      return Icons.ac_unit;
    } else {
      return Icons.thunderstorm;
    }
  }

  Color get iconColor {
    if (weatherCode == 0) {
      return const Color(0xFFFFD54F);
    }

    if (weatherCode >= 51 && weatherCode <= 67) {
      return const Color(0xFF64B5F6);
    }

    return const Color(0xFF90CAF9);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF102A59),
            Color(0xFF07183B),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFF234C8C),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2196F3).withOpacity(0.15),
            blurRadius: 25,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                color: Color(0xFF64B5F6),
                size: 20,
              ),
              const SizedBox(width: 6),
              Text(
                city,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Icon(
            weatherIcon,
            size: 100,
            color: iconColor,
          ),

          const SizedBox(height: 10),

          Text(
            temperature,
            style: const TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            condition,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 25),

          Row(
            children: [
              Expanded(
                child: _detailCard(
                  Icons.water_drop,
                  humidity,
                  'Humidity',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _detailCard(
                  Icons.air,
                  wind,
                  'Wind',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailCard(
    IconData icon,
    String value,
    String title,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0B2450),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF183E76),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: const Color(0xFF64B5F6),
            size: 25,
          ),
          const SizedBox(height: 7),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}