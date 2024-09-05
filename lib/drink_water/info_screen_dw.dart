import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

class InfoScreenDw extends StatelessWidget {
  const InfoScreenDw({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final textColor = themeProvider.currentTheme.brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Informationen zu Drink Water:'),
        iconTheme: const IconThemeData(
          color: Colors.white, // Farbe für den "Zurück"-Pfeil setzen
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              color: textColor, // Farbe basierend auf dem aktuellen Theme
              fontSize: 16.0,
            ),
            children: const [
              TextSpan(
                text: '1. Importe:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Die notwendigen Pakete werden importiert, einschließlich flutter, shared_preferences, '
                    'geolocator, http, dart:convert und die benutzerdefinierte notification_plan_screen.dart.\n\n',
              ),
              TextSpan(
                text: '2. StatefulWidget-Klasse (WaterIntakeSettings):\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Die Hauptklasse für den Bildschirm, die die Benutzereinstellungen verwaltet.\n\n',
              ),
              TextSpan(
                text: '3. State-Klasse (WaterIntakeSettingsState):\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Verwaltet den Zustand des Bildschirms und enthält die Logik für die '
                    'Benutzereingaben, Temperatur- und Standortdaten, und die Berechnung der Wasseraufnahme.\n\n',
              ),
              TextSpan(
                text: '4. Variablen:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Speichert die Benutzereinstellungen wie Gewicht, Alter, Aktivitätsniveau, Temperatur, Benutzername '
                    'und Standortname.\n\n',
              ),
              TextSpan(
                text: '5. initState:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Lädt die gespeicherten Benutzereinstellungen und ruft Temperatur- und Standortdaten ab, wenn der '
                    'Bildschirm geladen wird.\n\n',
              ),
              TextSpan(
                text: '6. _loadPreferences und _savePreferences:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Methoden zum Laden und Speichern der Benutzereinstellungen mit SharedPreferences.\n\n',
              ),
              TextSpan(
                text: '7. _getTemperatureAndLocation:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Ruft die aktuelle Temperatur und den Standort des Benutzers ab und aktualisiert '
                    'die entsprechenden Variablen.\n\n',
              ),
              TextSpan(
                text: '8. _getCurrentPosition:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Holt die aktuelle GPS-Position des Benutzers, einschließlich der Berechtigungsprüfung '
                    'für den Zugriff auf Standortdaten.\n\n',
              ),
              TextSpan(
                text: '9. _fetchTemperature und _fetchLocationName:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: 'Methoden zum Abrufen der aktuellen Temperatur und des '
                    'Standortnamens von externen APIs.\n\n',
              ),
              TextSpan(
                text: '10. calculateWaterIntake:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Berechnet die empfohlene Wasseraufnahme basierend auf Gewicht, Alter, '
                    'Aktivitätsniveau und Temperatur.\n\n',
              ),
              TextSpan(
                text: '11. _updateActivityDescription:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Aktualisiert die Beschreibung des Aktivitätsniveaus basierend auf der Auswahl '
                    'des Benutzers.\n\n',
              ),
              TextSpan(
                text: '12. _navigateToNotificationPlanScreen:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Navigiert zum Bildschirm zur Benachrichtigungsplanung und übergibt '
                    'die berechnete Wasseraufnahme.\n\n',
              ),
              TextSpan(
                text: '13. build-Methode:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Erstellt die Benutzeroberfläche des Bildschirms, einschließlich Textfeldern, '
                    'Dropdown-Menüs und Buttons. Die Benutzeroberfläche ermöglicht das Eingeben von Daten und die Berechnung der '
                    'Wasseraufnahme.\n',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
