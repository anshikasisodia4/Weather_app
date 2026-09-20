import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF020B20),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF42A5F5),
          brightness: Brightness.dark,
        ),
      ),
      home: const SplashPage(),
    );
  }
}