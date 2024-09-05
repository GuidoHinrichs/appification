import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Holt die aktuelle Position des Users
Future<Position> getCurrentPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Standortdienste nicht verfügbar.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Standortdienste dauerhaft deaktiviert.'); // Fehlerbehandlung
    }
    if (permission == LocationPermission.denied) {
      throw Exception('Standortdienste nicht erteilt.'); // Fehlerbehandlung
    }
  }
  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}

// Holt die aktuelle Temperatur basierend auf den GPS-Koordinaten
Future<double> fetchTemperature(double latitude, double longitude) async {
  try {
    const apiKey =
        'xxx'; // API-Key für openweathermap.org
    final url =
        'xxx';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['main']['temp'];
    } else {
      throw Exception(
          'Failed to load temperature: ${response.statusCode}'); // Fehlerbehandlung
    }
  } catch (e) {
    throw Exception('Error fetching temperature: $e'); // Fehlerbehandlung
  }
}

// Holt den Standortnamen basierend auf den GPS-Koordinaten
Future<String> fetchLocationName(double latitude, double longitude) async {
  try {
    final url =
        'xxx';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['address']['city'] ??
          data['address']['town'] ??
          data['address']['village'] ??
          'Unbekannter Standort';
    } else {
      throw Exception(
          'Der Ortsname konnte nicht geladen werden: ${response.statusCode}'); // Fehlerbehandlung
    }
  } catch (e) {
    throw Exception(
        'Fehler beim Abrufen des Ortsnamens: $e'); // Fehlerbehandlung
  }
}

// Holt die aktuelle Temperatur und den Standort des Users
Future<void> getTemperatureAndLocation(Function(double) onTemperatureFetched,
    Function(String) onLocationNameFetched) async {
  try {
    final position = await getCurrentPosition(); // aktuelle Position
    final temp = await fetchTemperature(
        position.latitude, position.longitude); // aktuelle Temperatur
    final location = await fetchLocationName(
        position.latitude, position.longitude); // Standortname
    onTemperatureFetched(temp);
    onLocationNameFetched(location);
  } catch (e) {
    onTemperatureFetched(0.0);
    onLocationNameFetched('Deinem Standort');
  }
}
