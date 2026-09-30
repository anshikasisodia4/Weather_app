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
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF173A72),
            Color(0xFF0B2045),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white10,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),

        leading: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFF24508D),
            borderRadius: BorderRadius.circular(17),
          ),
          child: const Icon(
            Icons.location_on_rounded,
            color: Color(0xFF8CCBFF),
            size: 26,
          ),
        ),

        title: Text(
          city,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),

        subtitle: const Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text(
            'Tap to view weather',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),
        ),

        trailing: IconButton(
          onPressed: onDelete,
          icon: const Icon(
            Icons.delete_outline_rounded,
            color: Colors.white70,
            size: 24,
          ),
        ),
      ),
    );
  }
}