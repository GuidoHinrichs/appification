import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:guidohinrichs/drink_water/notification_plan_screen.dart';
import 'info_screen_dw.dart';
import 'preferences_service.dart';
import 'location_service.dart';
import 'water_intake_calculator.dart';

// Hauptklasse für die Bildschirmeinstellungen der Drink_Water-Anwendung
class WaterIntakeSettings extends StatefulWidget {
  const WaterIntakeSettings({super.key});

  @override
  _WaterIntakeSettingsState createState() => _WaterIntakeSettingsState();
}

class _WaterIntakeSettingsState extends State<WaterIntakeSettings> {
  // Variablen zur Speicherung der Benutzereinstellungen
  int _selectedWeight = 60; // Default-Gewicht des Users
  int _selectedAge = 25; // Default-Alter des Users
  String _selectedActivityLevel = 'NORMAL'; // Default-Aktivität des Users
  double _temperature = 0.0; // Default-Temperatur
  String _userName = ''; // Default-Name
  bool _isNameEditable = true; // Bearbeitbarkeit des Namens
  String _locationName = 'Deinem Standort'; // Default-Standort
  String _activityDescription =
      'SWAYING DAY: Normale körperliche Aktivität'; // Default-Beschreibung der Aktivität

  // Liste der Aktivitätsniveaus
  final List<String> _activityLevels = ['NIEDRIG', 'NORMAL', 'MEDIUM', 'HOCH'];

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Lädt die gespeicherten Benutzereinstellungen
    getTemperatureAndLocation(
      (temp) {
        setState(() {
          _temperature = temp;
        });
      },
      (location) {
        setState(() {
          _locationName = location;
        });
      },
    );
  }

  // Lädt die Benutzereinstellungen aus den SharePreferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedWeight = prefs.getInt('selectedWeight') ?? 60;
      _selectedAge = prefs.getInt('selectedAge') ?? 25;
      _selectedActivityLevel =
          prefs.getString('selectedActivityLevel') ?? 'NORMAL';
      _userName = prefs.getString('userName') ?? '';
      _isNameEditable =
          _userName.isEmpty; // Bearbeitung des Namens, wenn er leer ist
    });
  }

  // Schaltet die Bearbeitbarkeit des Namens ein oder aus und speichert die Änderungen
  void _toggleNameEdit() {
    setState(() {
      _isNameEditable = !_isNameEditable;
      if (!_isNameEditable) {
        savePreferences; // Speichert die Änderungen, wenn der Name bearbeitet ist
      }
    });
  }
  // Aktualisiert die Beschreibung des Aktivitätsniveaus basierend auf der Auswahl
  void _updateActivityDescription() {
    switch (_selectedActivityLevel) {
      case 'NIEDRIG':
        _activityDescription = 'SLEEPY DAY: Geringe körperliche Aktivität';
        break;
      case 'NORMAL':
        _activityDescription = 'SWAYING DAY: Normale körperliche Aktivität';
        break;
      case 'MEDIUM':
        _activityDescription = 'MAKING DAY: Mittlere körperliche Aktivität';
        break;
      case 'HOCH':
        _activityDescription = 'HEAVY DAY: Sehr hohe körperliche Aktivität';
        break;
      default:
        _activityDescription = '';
    }
  }

  // Navigiert zum NotificationPlanScreen und übergibt die berechnete Wasseraufnahme
  void _navigateToNotificationPlanScreen(
      BuildContext context, double calculatedIntake) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            NotificationPlanScreen(calculatedIntake: calculatedIntake),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    bool isNarrowScreen = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trink Wasser!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: theme.colorScheme.primary,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InfoScreenDw(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: isNarrowScreen ? screenWidth * 0.9 : 600,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Wie viel sollte man am Tag trinken?',
                                style: TextStyle(
                                    color: theme.colorScheme.onSurface,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              // InfoDialog für Erklärtexte zur Wasseraufnahme
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Die richtige Trinkmenge',
                                    style: TextStyle(
                                        color: theme.colorScheme.onSurface,
                                        fontSize: 16.0),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.info,
                                        color: theme.colorScheme.onSurface),
                                    onPressed: () {
                                      _showInfoDialog(
                                          'Die richtige Trinkmenge',
                                          'Ausreichendes Trinken ist entscheidend für Wohlbefinden und Leistungsfähigkeit, '
                                              'da unser Körper zu fast zwei Dritteln aus Wasser besteht. Wasser erfüllt viele '
                                              'wichtige Funktionen, wie den Transport von Nährstoffen, die Ausscheidung von '
                                              'Stoffwechselendprodukten und die Regulierung der Körpertemperatur durch Schwitzen. '
                                              'Da wir ständig Wasser durch Nieren, Lunge, Haut und Urin verlieren, ist regelmäßiges '
                                              'Nachfüllen notwendig. \n\n'
                                              'Eine tägliche Flüssigkeitszufuhr von mindestens 1,5 Litern ist empfehlenswert, kann '
                                              'jedoch an heißen Tagen, beim Sport oder bei körperlicher Arbeit deutlich steigen. '
                                              'Der tatsächliche Bedarf hängt auch von Alter, Geschlecht, Gesundheitszustand und '
                                              'Körpergröße ab. Größere Körperoberflächen verlieren mehr Wasser über die Haut.');
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Was, wenn ich zu wenig trinke?',
                                    style: TextStyle(
                                        color: theme.colorScheme.onSurface,
                                        fontSize: 16.0),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.info,
                                        color: theme.colorScheme.onSurface),
                                    onPressed: () {
                                      _showInfoDialog(
                                          'Was, wenn ich zu wenig trinke?',
                                          'Schon ein leichter Flüssigkeitsmangel kann gesundheitliche Probleme verursachen, '
                                              'wie trockene Haut, rissige Lippen, Mundtrockenheit, Müdigkeit, Konzentrationsschwäche, '
                                              'Kopfschmerzen, Erschöpfung, Schwindel und Verwirrtheit, besonders bei älteren Menschen. '
                                              'Weitere Symptome sind Verstopfung, niedriger Kreislauf, reduzierte Nierenfunktion und '
                                              'erhöhte Anfälligkeit für Harnwegsinfekte. Im Sommer kann auch das Risiko eines Hitzschlags steigen.\n\n'
                                              'Die gute Nachricht: Wer nachträglich genug trinkt, kann die Auswirkungen rasch beheben. '
                                              'Vorsorgliches Trinken hilft nicht, da der Körper Wasser nicht speichern kann. Es ist besser, '
                                              'regelmäßig über den Tag verteilt zu trinken, etwa alle zwei Stunden ein Glas.');
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Was kann ich trinken?',
                                    style: TextStyle(
                                        color: theme.colorScheme.onSurface,
                                        fontSize: 16.0),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.info,
                                        color: theme.colorScheme.onSurface),
                                    onPressed: () {
                                      _showInfoDialog(
                                          'Was kann ich trinken?',
                                          'Am besten trinken Sie gefiltertes Leitungswasser, Mineralwasser und ungesüßte Kräuter- '
                                              'oder Früchtetees. Saftschorlen im Verhältnis 1 Teil Saft zu 3 Teilen Wasser '
                                              'sind ebenfalls gute Durstlöscher. Kalorienfreie Softgetränke und Energy-Drinks '
                                              'sind nicht empfehlenswert, da sie oft Süßungsmittel und Aromastoffe enthalten, '
                                              'die die Vorliebe für Süßes steigern können. Gesüßte Getränke sollten vermieden '
                                              'werden, da sie viele unnötige Kalorien enthalten und zu Gewichtszunahme führen '
                                              'können. Kaffee und schwarzer Tee ohne Zucker können zur Flüssigkeitsbilanz beitragen, '
                                              'sollten jedoch aufgrund des Koffeins in Maßen genossen werden – etwa drei bis vier '
                                              'Tassen täglich sind unbedenklich.');
                                    },
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Trinkmuffel? Diese Tipps helfen',
                                    style: TextStyle(
                                        color: theme.colorScheme.onSurface,
                                        fontSize: 16.0),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.info,
                                        color: theme.colorScheme.onSurface),
                                    onPressed: () {
                                      _showInfoDialog(
                                          'Trinkmuffel? Diese Tipps helfen',
                                          'Viele Menschen haben Schwierigkeiten, genug Flüssigkeit am Tag zu sich zu '
                                              'nehmen. Etwa ein Drittel der Menschen in Deutschland trinkt nicht '
                                              'ausreichend Wasser. Wenn Sie Durst verspüren, sollten Sie handeln und '
                                              'am besten Leitungswasser trinken. Die täglichen 1,5 Liter sollten über '
                                              'den Tag verteilt getrunken werden, um Kopfschmerzen, Schwindel und '
                                              'Kreislaufproblemen vorzubeugen. Dies ist besonders wichtig bei heißem '
                                              'Wetter, körperlicher Aktivität oder Sport. Vorratstrinken bringt nichts, '
                                              'da der Körper Wasser nicht speichern kann. Erinnerungen auf dem '
                                              'Smartphone, eine Trinkliste oder eine stets griffbereite Flasche Wasser '
                                              'können hilfreich sein. Wenn Leitungswasser langweilig wird, können Sie '
                                              'es kalorienfrei mit Bio-Zitrusfrüchten, Kräutern, Gurke, Dill, Ingwer '
                                              'oder Minze verfeinern.');
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Wasser kann man auch essen',
                                    style: TextStyle(
                                        color: theme.colorScheme.onSurface,
                                        fontSize: 16.0),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.info,
                                        color: theme.colorScheme.onSurface),
                                    onPressed: () {
                                      _showInfoDialog(
                                          'Wasser kann man auch essen',
                                          'Wasser kann man auch essen! Viele Gemüse- und Obstsorten wie Salat, Tomaten, Gurken, '
                                              'Sellerie, Melonen, Pfirsiche, Trauben und Erdbeeren bestehen zu über 90 Prozent aus Wasser. '
                                              'Diese Lebensmittel sind im Sommer saisonal verfügbar und unterstützen den Körper besonders '
                                              'gut an heißen Tagen. Zudem sind sie reich an leicht verdaulichen Ballaststoffen, was bei '
                                              'hohen Temperaturen von Vorteil ist, da man leichte Kost bevorzugen sollte. Gesüßte Getränke '
                                              'wie Softdrinks oder unverdünnte Fruchtsäfte sind weniger geeignet, da sie bei viel Schwitzen '
                                              'das Blut im Verdauungstrakt verdicken und zusätzliche Arbeit für den Körper bedeuten.');
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Hier wird das Gewicht eingegeben
                        Text(
                          'Dein Gewicht',
                          style: TextStyle(
                              color: theme.colorScheme.onSurface,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('45 kg'),
                            Text(
                              '$_selectedWeight kg',
                              style: TextStyle(
                                  color: theme.colorScheme.onSurface,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text('120 kg'),
                          ],
                        ),
                        Slider(
                          value: _selectedWeight.toDouble(),
                          min: 45,
                          max: 120,
                          divisions: 75,
                          label: '$_selectedWeight kg',
                          onChanged: (double newValue) {
                            setState(() {
                              _selectedWeight = newValue.round();
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        // Hier wird das Alter eingegeben
                        Text(
                          'Dein Alter',
                          style: TextStyle(
                              color: theme.colorScheme.onSurface,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('18 Jahre'),
                            Text(
                              '$_selectedAge Jahre',
                              style: TextStyle(
                                  color: theme.colorScheme.onSurface,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text('85 Jahre'),
                          ],
                        ),
                        Slider(
                          value: _selectedAge.toDouble(),
                          min: 18,
                          max: 85,
                          divisions: 87,
                          label: '$_selectedAge Jahre',
                          onChanged: (double newValue) {
                            setState(() {
                              _selectedAge = newValue.round();
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        _isNameEditable
                            ? Column(
                          children: [
                            Text(
                              'Dein Name',
                              style: TextStyle(
                                  color: theme.colorScheme.onSurface,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Center(
                              child: SizedBox(
                                width: 250,
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Gib deinen Namen ein',
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _userName = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                            : Column(
                          children: [
                            Text(
                              'Hallo $_userName',
                              style: TextStyle(
                                  color: theme.colorScheme.onSurface,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Center(
                              child: ElevatedButton(
                                onPressed: _toggleNameEdit,
                                child: const Text(
                                    'Benutzer wechseln'), // Useränderung
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Hier wird Standort und Temperatur angezeigt
                        Center(
                          child: Text(
                            'Aktuelle Temperatur in $_locationName: ${_temperature.toStringAsFixed(1)} °C',
                            style: TextStyle(
                                color: theme.colorScheme.onSurface,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Aktivitätsniveau',
                          style: TextStyle(
                              color: theme.colorScheme.onSurface,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        // Hier wird das Aktivitätsniveau abgefragt
                        Center(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: _activityLevels
                                  .map((level) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: ChoiceChip(
                                          label: Text(level),
                                          selected:
                                              _selectedActivityLevel == level,
                                          onSelected: (bool selected) {
                                            setState(() {
                                              _selectedActivityLevel = selected
                                                  ? level
                                                  : _selectedActivityLevel;
                                              _updateActivityDescription();
                                            });
                                          },
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                        if (_selectedActivityLevel.isNotEmpty)
                          // Hier wird das Aktivitätsniveau erklärt
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                _activityDescription,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 20),
                        // Button 'Benachrichtigungen einrichten' mit Logik
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              double dailyIntake = calculateWaterIntake(
                                  _selectedWeight,
                                  _selectedAge,
                                  _selectedActivityLevel,
                                  _temperature);
                              savePreferences;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Benachrichtigungen für ${dailyIntake.toStringAsFixed(2)} Liter Wasser pro Tag eingerichtet.'),
                                ),
                              );
                              _navigateToNotificationPlanScreen(
                                  context,
                                  calculateWaterIntake(
                                      _selectedWeight,
                                      _selectedAge,
                                      _selectedActivityLevel,
                                      _temperature));
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text('Benachrichtigungen einrichten'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ), // Aktivierung der BottomAppBar
      bottomNavigationBar: BottomAppBar(
        color: theme.colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Empfohlene tägliche Trinkmenge: ${calculateWaterIntake(_selectedWeight, _selectedAge, _selectedActivityLevel, _temperature).toStringAsFixed(2)} Liter.',
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  // UI der Info-Dialoge
  void _showInfoDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface, // Farbe für den Titeltext
            ),
          ),
          content: Text(
            content,
            style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface, // Farbe für den Inhaltstext
            ),
          ),
          backgroundColor: Theme.of(context)
              .colorScheme
              .surface, // Hintergrundfarbe des Dialogs
          actions: [
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .primary, // Farbe für die Schaltfläche
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
