import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 3, 10, 16),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'No favorite cities yet',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}