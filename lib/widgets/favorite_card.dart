import 'package:flutter/material.dart';

class FavoriteCard extends StatelessWidget {
  final String city;
  final VoidCallback onDelete;

  const FavoriteCard({
    super.key,
    required this.city,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
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
          onPressed: onDelete,
          icon: const Icon(
            Icons.delete_outline,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}