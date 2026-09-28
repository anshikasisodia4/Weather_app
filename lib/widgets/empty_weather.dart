import 'package:flutter/material.dart';

class EmptyWeather extends StatelessWidget {
  const EmptyWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF102A59),
            Color(0xFF071735),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud,
            size: 90,
            color: Color(0xFF90CAF9),
          ),
          SizedBox(height: 15),
          Text(
            'Search for a city',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Get the latest weather updates',
            style: TextStyle(color: Colors.white54),
          ),
        ],
      ),
    );
  }
}