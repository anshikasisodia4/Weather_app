# weather_app
A Flutter Project


## Getting Started

Breezy 🌤️

Breezy is a modern Flutter weather application that allows users to search for cities, view real-time weather information, and save their favorite cities using Firebase Firestore.

Features
🌍 Search weather by city name
🌡️ Display current temperature
☁️ Display current weather condition
💧 Display humidity
💨 Display wind speed
⭐ Add cities to favorites
🗑️ Delete favorite cities
☁️ Firebase Firestore integration for storing favorites
🎨 Modern dark blue weather UI
📱 Responsive Flutter interface
🔄 Loading indicators and error handling
🚫 Prevent duplicate favorite cities
Technologies Used
Flutter
Dart
Open-Meteo Weather API
Firebase
Cloud Firestore
Material 3
API

Breezy uses the Open-Meteo API to retrieve weather information.

The app first uses the Open-Meteo Geocoding API to find the latitude and longitude of a searched city. It then uses the weather forecast API to retrieve current weather information.

The application retrieves:

Temperature
Humidity
Wind speed
Weather code
Firebase

Firebase is used to store favorite cities.

The Firestore collection used by the application is:

favorites

Each favorite city is stored with:

city: "Delhi"

The application prevents the same city from being stored multiple times.

Project Structure
lib/
│
├── main.dart
│
├── firebase_options.dart
│
├── pages/
│   ├── splash_page.dart
│   ├── home_page.dart
│   └── favorites_page.dart
│
├── services/
│   ├── weather_service.dart
│   └── favorite_service.dart
│
└── widgets/
    ├── weather_card.dart
    └── favorite_card.dart
How It Works
User enters city
        ↓
Open-Meteo Geocoding API
        ↓
Latitude & Longitude
        ↓
Open-Meteo Weather API
        ↓
Temperature / Humidity / Wind / Condition
        ↓
Weather Card

For favorites:

User searches city
        ↓
Add to Favorites
        ↓
Firebase Firestore
        ↓
favorites collection
        ↓
Favorite Cities displayed in app
Getting Started
1. Clone the repository
git clone YOUR_GITHUB_REPOSITORY_URL
2. Open the project
cd weather_app
3. Install dependencies
flutter pub get
4. Configure Firebase

Make sure your Firebase project is connected to the Flutter project using:

flutterfire configure

Select the Firebase project used by Breezy.

5. Enable Cloud Firestore

In Firebase Console:

Firebase Console
→ Build
→ Firestore Database
→ Create Database
6. Run the application
flutter run
Screens

The application contains:

Splash Screen
Home / Weather Search Screen
Weather Details Card
Favorite Cities Section
Favorites Screen
UI Design

Breezy uses a dark weather-themed interface with:

Dark navy background
Blue gradient weather cards
Rounded corners
Blue accent buttons
Weather icons
Clean typography
Modern Material 3 components
Requirements

Before running the project, make sure you have:

Flutter SDK installed
Dart SDK
Android Studio or VS Code
Android emulator or physical Android device
Firebase project
Internet connection

Author
Anshika

Breezy — Flutter Weather Application 🌤️