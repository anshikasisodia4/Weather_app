import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

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
      body: Container(
        color: const Color(0xFFF3F8FC),
        child: DummyData.favoriteCities.isEmpty
            ? const Center(
                child: Text(
                  'No favorite cities yet',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: DummyData.favoriteCities.length,
                itemBuilder: (context, index) {
                  final city = DummyData.favoriteCities[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      leading: const CircleAvatar(
                        radius: 25,
                        backgroundColor: Color(0xFFE3F2FD),
                        child: Icon(
                          Icons.location_on,
                          color: Color(0xFF42A5F5),
                        ),
                      ),
                      title: Text(
                        city,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text(
                        'Favorite city',
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

