import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

class InfoScreenStopSmoking extends StatelessWidget {
  const InfoScreenStopSmoking({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final textColor = themeProvider.currentTheme.brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Informationen zur Stop Smoking App'),
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
                    'Die notwendigen Pakete werden importiert, einschließlich flutter, provider und weitere benötigte Pakete für die Datenverarbeitung und UI-Komponenten.\n\n',
              ),
              TextSpan(
                text: '2. Hauptklasse (StopSmokingApp):\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Die Hauptklasse der Anwendung, die die verschiedenen Bildschirme und die Navigationslogik verwaltet.\n\n',
              ),
              TextSpan(
                text: '3. StatefulWidget-Klassen:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Verwaltet den Zustand der Anwendung, einschließlich der Benutzerinteraktionen, des Fortschritts beim Rauchstopp und der täglichen Rauchgewohnheiten.\n\n',
              ),
              TextSpan(
                text: '4. Variablen:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Speichert die Benutzereinstellungen wie tägliche Zigarettenzahl, Fortschritt beim Rauchstopp und statistische Daten.\n\n',
              ),
              TextSpan(
                text: '5. initState:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Lädt die gespeicherten Benutzereinstellungen und initialisiert die Anwendung beim Start.\n\n',
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
                text: '7. _updateProgress:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Aktualisiert den Fortschritt des Benutzers beim Rauchstopp und speichert diesen.\n\n',
              ),
              TextSpan(
                text: '8. _fetchStatistics:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Ruft aktuelle Statistiken und Fortschritte von externen Datenquellen oder APIs ab.\n\n',
              ),
              TextSpan(
                text: '9. _resetProgress:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Setzt den Fortschritt zurück und ermöglicht dem Benutzer einen neuen Start beim Rauchstopp.\n\n',
              ),
              TextSpan(
                text: '10. build-Methode:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Erstellt die Benutzeroberfläche der Anwendung, einschließlich der Darstellung von Fortschritt, Tipps zum Rauchstopp und Interaktionsmöglichkeiten für den Benutzer.\n',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
