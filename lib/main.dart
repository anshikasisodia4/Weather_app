import 'package:flutter/material.dart';
import 'pages/splash_page.dart';

void main() {
  runApp(const BreezyApp());
}

class BreezyApp extends StatelessWidget {
  const BreezyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Breezy',

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 4, 18, 30),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5FAFF),
      ),

      home: const SplashPage(),
    );
  }
}
