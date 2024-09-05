import 'dart:math';
import 'package:flutter/material.dart';
import 'package:guidohinrichs/meet_your_colleague/person.dart';
import 'package:guidohinrichs/meet_your_colleague/person_repository.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import 'call_handler.dart';
import 'Info_screen_myc.dart';

class PhoningScreen extends StatefulWidget {
  const PhoningScreen({super.key});

  @override
  _PhoningScreenState createState() => _PhoningScreenState();
}

class _PhoningScreenState extends State<PhoningScreen> {
  final Random _random = Random(); // Zufallszahlengenerator
  late List<Person> _persons; // Liste der Personen
  late Person _selectedPerson; // Ausgewählte Person
  late CallHandler _callHandler; // Handler für Anrufe

  @override
  void initState() {
    super.initState();
    _callHandler = CallHandler(
        context); // Initialisiert den CallHandler mit dem Build-Kontext
    _loadPersons(); // Lädt die Personenliste
  }

  void _loadPersons() {
    _persons = PersonRepository().persons ??
        []; // Holt die Liste der Personen oder setzt sie auf leer, wenn keine vorhanden sind
    _selectRandomPerson(); // Wählt eine zufällige Person aus der Liste aus
  }

  void _selectRandomPerson() {
    setState(() {
      _selectedPerson = _persons[_random.nextInt(_persons
          .length)]; // Setzt die ausgewählte Person auf eine zufällige Person aus der Liste
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = themeProvider.currentTheme; // Holt das aktuelle Theme

    return Scaffold(
      appBar: AppBar(
        title: Text('Meet Your Colleague',
            style: themeProvider.titleTextStyle.copyWith(color: Colors.white)),
        backgroundColor:
            Colors.teal, // Setze eine dunkle Hintergrundfarbe für die AppBar
        foregroundColor: Colors
            .white, // Stelle sicher, dass der Text in der AppBar weiß ist // Verwendet den T;extstil für Titel aus dem Theme
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InfoScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Hinzugefügt für Scrollbarkeit
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 90.0), // Platzhalter für Abstand
              const SizedBox(height: 40), // Abstand zwischen Elementen
              const Icon(Icons.face_4,
                  size: 40, color: Color(0xFF899294)), // Icon für Gesichter
              const Icon(Icons.phone,
                  color: Color(0xFF006874)), // Icon für Telefon
              const Icon(Icons.face,
                  size: 40, color: Color(0xFFFFB4AB)), // Icon für Gesichter
              const SizedBox(height: 20), // Abstand zwischen Elementen
              Text(
                'Meet Your Colleague',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontSize: 28,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: theme
                      .colorScheme.onSurface, // Textfarbe aus dem Farbschema
                ),
              ), // Überschrift
              const SizedBox(height: 20.0), // Platzhalter für Abstand
              Text(
                'Lerne Kollegen und Kolleginnen kennen,\ntelefoniere JETZT mit ihnen.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 12.0,
                  color: theme
                      .colorScheme.onSurface, // Textfarbe aus dem Farbschema
                ),
              ), // Anleitungstext
              const SizedBox(height: 40.0), // Platzhalter für Abstand
              if (_persons
                  .isNotEmpty) // Wenn die Liste der Personen nicht leer ist
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed:
                          _selectRandomPerson, // Wählt eine zufällige Person aus, wenn der Button gedrückt wird
                      child: const Text('Select Colleague'),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Selected Person:',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontSize: 12,
                        color: theme.colorScheme
                            .onSurface, // Textfarbe aus dem Farbschema
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${_selectedPerson.firstname} ${_selectedPerson.lastname}', // Zeigt den Namen der ausgewählten Person an
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 20,
                        color: theme.colorScheme
                            .onSurface, // Textfarbe aus dem Farbschema
                      ),
                    ),
                    Text(
                      _selectedPerson
                          .position, // Zeigt die Position der ausgewählten Person an
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                        color: theme.colorScheme
                            .onSurface, // Textfarbe aus dem Farbschema
                      ),
                    ),
                    Text(
                      _selectedPerson
                          .location, // Zeigt den Standort der ausgewählten Person an
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                        color: theme.colorScheme
                            .onSurface, // Textfarbe aus dem Farbschema
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () => _callHandler.makeCall(
                          _selectedPerson), // Startet einen Anruf zur ausgewählten Person, wenn der Button gedrückt wird
                      child: const Text('Verbinden'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
