import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final textColor = themeProvider.currentTheme.brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: const Text('App Information'),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 16, color: textColor),
                    children: [
                      const TextSpan(
                        text: 'Warum diese App?\n',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text:
                            '\nWarum sollte ein Flutter-Entwickler auf Papier verzichten? Weil es viel aussagekräftiger ist, '
                            'seine Fähigkeiten durch funktionierende Anwendungen zu demonstrieren, anstatt sie nur '
                            'aufzulisten. Deshalb habe ich mich entschieden, eine "Minimum Viable Product"-App zu '
                            'entwickeln, die meine Herangehensweise an verschiedene Herausforderungen bei der Erstellung '
                            'von Software für Android- und iOS-Geräte dokumentiert.\n\n',
                      ),
                      const TextSpan(
                        text: 'Anwendungen:\n',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text: '\n1. ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'Quiz-App:\n',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: textColor),
                      ),
                      const TextSpan(
                        text:
                            'Effektive Verwaltung von Anwendungszuständen und Benutzerinteraktionen, '
                            'asynchrone Programmierung mit "State Management" und "Future-delayed".\n\n',
                      ),
                      const TextSpan(
                        text: '2. ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'Meet Your Colleague:\n',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: textColor),
                      ),
                      const TextSpan(
                        text:
                            'Effektive Verwaltung des App-Zustands und dynamisches Laden von '
                            'Personendaten. Implementierung von Video-Call-Funktionen für Android und iOS und Interaktion '
                            'über Widgets, Buttons und Dialoge.\n\n',
                      ),
                      const TextSpan(
                        text: '3. ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'Stop Smoking:\n',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: textColor),
                      ),
                      const TextSpan(
                        text:
                            'UI-Entwicklung, Picker-Komponenten, Datenbankmanagement mit SQLite, '
                            'asyncrone Programmierung, PDF-Generierung verpackt in ein reponsives Design.\n\n',
                      ),
                      const TextSpan(
                        text: '4. ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'Drink Water:\n',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: textColor),
                      ),
                      const TextSpan(
                        text:
                            'Benachrichtigungsmanagement, Datenmanipulation, Event Handling, Shared Preferences, '
                            'API-Integration.\n\n',
                      ),
                      const TextSpan(
                        text: '5. ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'Milestones:\n',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: textColor),
                      ),
                      const TextSpan(
                        text: 'Mein Kurzprofil mit Kernkompetenzen.\n',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
