# Breezy – Weather App

Breezy is a simple Flutter weather application that shows real-time weather information for different cities.

## Features

* Get current temperature
* View humidity
* View wind speed
* Search weather by city
* Add cities to favorites
* Delete favorite cities
* Fetch current weather for favorite cities
* Firebase Firestore for storing favorite cities
* Loading and error handling

## Technologies Used

* Flutter
* Dart
* Open-Meteo Weather API
* Firebase Firestore
* HTTP package

## How It Works

1. Enter a city name.
2. Breezy finds the city's latitude and longitude using the Open-Meteo Geocoding API.
3. The Weather API provides the current weather data.
4. The weather information is displayed in the app.
5. Favorite cities are stored in Firebase Firestore.
6. Tapping a favorite city fetches its latest temperature.



## Setup

1. Install Flutter.
2. Clone or download this project.
3. Run:

flutter pub get

4. Configure Firebase for the project.
5. Run the application:


flutter run

## API

Breezy uses the Open-Meteo API for weather and geocoding data.

No API key is required.

## Firebase

Firebase Firestore is used to store favorite cities.


## Author
Anshika
