import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0C1F42),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF21477F),
        ),
      ),
      child: TextField(
        controller: controller,
        onSubmitted: (_) => onSearch(),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search city...',
          hintStyle: const TextStyle(color: Colors.white54),
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFF64B5F6),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(6),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF42A5F5),
              ),
              child: IconButton(
                onPressed: onSearch,
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 17),
        ),
      ),
    );
  }
}