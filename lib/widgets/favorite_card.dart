import 'package:flutter/material.dart';

class FavoriteCard extends StatelessWidget {
  final String city;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const FavoriteCard({
    super.key,
    required this.city,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF102A59),
            Color(0xFF091C3E),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF1B4078),
        ),
      ),
      child: ListTile(
        onTap: onTap,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 8,
        ),

        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF12386D),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(
            Icons.location_on,
            color: Color(0xFF64B5F6),
          ),
        ),

        title: Text(
          city,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: const Text(
          'Tap to view weather',
          style: TextStyle(
            color: Colors.white54,
          ),
        ),

        trailing: IconButton(
          onPressed: onDelete,
          icon: const Icon(
            Icons.delete_outline,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}