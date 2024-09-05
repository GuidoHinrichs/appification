import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:guidohinrichs/theme_provider.dart';

class InfoScreenIcebreaker extends StatelessWidget {
  const InfoScreenIcebreaker({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final textColor = themeProvider.currentTheme.brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Informationen zu Icebreaker:'),
        backgroundColor: const Color(0xff00687a),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              color: textColor,
              fontSize: 16.0,
            ),
            children: const [
              TextSpan(
                text: '1. Importe:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Die notwendigen Pakete werden importiert, einschließlich flutter und die benutzerdefinierten Dateien quiz.dart, result.dart, question_storage.dart und question_storage_II.dart.\n\n',
              ),
              TextSpan(
                text: '2. StatefulWidget-Klasse (Icebreaker):\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Die Hauptklasse für das Quizspiel, die die Benutzeroberfläche und den Zustand verwaltet.\n\n',
              ),
              TextSpan(
                text: '3. State-Klasse (_IcebreakerState):\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Verwaltet den Zustand des Spiels, einschließlich der aktuellen Frage, der Gesamtpunktzahl, der aktuellen Runde und der Farben der Antwort-Buttons.\n\n',
              ),
              TextSpan(
                text: '4. Variablen:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Speichert den aktuellen Fragenindex, die Gesamtpunktzahl des Benutzers, die Abfrage, ob es sich um die erste Runde handelt, und die Farben der Antwort-Buttons.\n\n',
              ),
              TextSpan(
                text: '5. initState:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Initialisiert den Zustand des Spiels, einschließlich der Standardfarbe der Antwort-Buttons.\n\n',
              ),
              TextSpan(
                text: '6. _initializeButtonColors:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Setzt die Farben der Antwort-Buttons basierend auf der aktuellen Runde und der Frage.\n\n',
              ),
              TextSpan(
                text: '7. _answerQuestion:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Wird aufgerufen, wenn eine Antwort ausgewählt wird. Aktualisiert die Button-Farben basierend auf der Richtigkeit der Antwort und erhöht die Punktzahl entsprechend.\n\n',
              ),
              TextSpan(
                text: '8. _resetQuiz:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: 'Setzt das Quizspiel zurück und beginnt von vorne.\n\n',
              ),
              TextSpan(
                text: '9. _continuePlaying:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Startet die zweite Runde des Spiels mit einer neuen Fragenliste.\n\n',
              ),
              TextSpan(
                text: '10. build-Methode:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Erstellt die Benutzeroberfläche des Spiels, einschließlich der Anzeige der aktuellen Frage, der Antwort-Buttons und der Ergebnisse, sobald das Spiel vorbei ist.\n\n',
              ),
              TextSpan(
                text: '11. Quiz-Klasse:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Eine benutzerdefinierte StatelessWidget-Klasse, die die aktuellen Fragen und Antwortmöglichkeiten anzeigt und die Logik zum Beantworten von Fragen enthält.\n\n',
              ),
              TextSpan(
                text: '12. Question-Klasse:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Eine benutzerdefinierte StatelessWidget-Klasse, die den Text der aktuellen Frage anzeigt.\n\n',
              ),
              TextSpan(
                text: '13. Result-Klasse:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Eine benutzerdefinierte StatelessWidget-Klasse, die die Endergebnisse des Spiels anzeigt und Optionen zum Neustarten oder Fortsetzen des Spiels bietet.\n',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
