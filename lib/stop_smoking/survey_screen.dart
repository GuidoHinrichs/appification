import 'package:flutter/material.dart';
import 'package:guidohinrichs/stop_smoking/bubble_background.dart';
import 'package:guidohinrichs/stop_smoking/smoking_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter_picker/flutter_picker.dart';
import '../theme_provider.dart';
import 'package:guidohinrichs/stop_smoking/picker/picker_type.dart';
import 'database_helper.dart';
import 'option1_page.dart';
import 'option2_page.dart';
import 'option3_page.dart';
import 'option_card.dart';
import 'info_screen_stsm.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  // Variablen zum Speichern der Benutzereingaben
  int _selectedCigarettes = 1;
  String _firstCigaretteTime = '07:00';
  String _lastCigaretteTime = '22:00';
  int _morningCigarettes = 0;
  int _afternoonCigarettes = 0;
  int _eveningCigarettes = 0;

  // Variablen für Fortschritts- und Schrittstatus
  int _currentStep = 0;
  bool _showProgress = false;
  bool _calculationComplete = false;
  double _progressValue = 0.0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stop Smoking!',
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
                  builder: (context) => const InfoScreenStopSmoking(),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          const BubbleBackground(),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Container erste Frage
                    _buildStepContainer(
                      context,
                      themeProvider,
                      _buildPickerButton(
                        context,
                        themeProvider,
                        'Wieviele Zigaretten rauchst Du am Tag?',
                        '$_selectedCigarettes',
                        PickerType.cigarettes,
                        0,
                        theme,
                      ),
                      _currentStep == 0,
                      theme,
                    ),
                    if (_currentStep <=
                        5) // Bild zeigen, solange der currentStep <= 5 ist
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            'assets/images/rauchfrei.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    // Container für die Zeitabfragen
                    _buildStepContainer(
                      context,
                      themeProvider,
                      _buildFirstAndLastCigaretteRow(
                          context, themeProvider, theme),
                      _currentStep == 1 || _currentStep == 2,
                      theme,
                    ),
                    // Container für Anzahl Zigaretten
                    _buildStepContainer(
                      context,
                      themeProvider,
                      _buildMorningAfternoonEveningCigarettesRow(
                          context, themeProvider, theme),
                      _currentStep >= 3 && _currentStep <= 5,
                      theme,
                    ),
                    if (_showProgress)
                      Column(
                        children: [
                          Text(
                            'Danke für Dein Vertrauen. Deine verschiedenen Möglichkeiten mit dem Rauchen aufzuhören, werden berechnet.',
                            style:
                                themeProvider.currentTheme.textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 10),
                          LinearProgressIndicator(value: _progressValue),
                        ],
                      ),
                    if (_calculationComplete)
                      Column(
                        children: [
                          Text(
                            'Hier sind Deine Möglichkeiten:',
                            style:
                                themeProvider.currentTheme.textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 10),
                          _buildOptionsWrap(theme),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

// Erstellen der Container für die Schritte
  Widget _buildStepContainer(BuildContext context, ThemeProvider themeProvider,
      Widget child, bool isActive, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isActive ? theme.colorScheme.tertiaryFixed : Colors.transparent,
        borderRadius: BorderRadius.circular(5),
      ),
      child: child,
    );
  }

  // Erstellt Button für Picker
  Widget _buildPickerButton(
    BuildContext context,
    ThemeProvider themeProvider,
    String title,
    String buttonText,
    PickerType pickerType,
    int step,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: themeProvider.currentTheme.textTheme.titleLarge,
        ),
        const SizedBox(height: 5),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _currentStep == step
                ? theme.colorScheme.tertiaryContainer
                : theme.colorScheme.surfaceContainerHighest,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 4,
            shadowColor: theme.colorScheme.shadow,
          ),
          onPressed: _currentStep == step
              ? () {
                  _showPicker(context, pickerType);
                }
              : null,
          child: Text(buttonText),
        ),
      ],
    );
  }

  // Erstellen der Zeitabfragen
  Widget _buildFirstAndLastCigaretteRow(
      BuildContext context, ThemeProvider themeProvider, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildPickerButton(
                context,
                themeProvider,
                'Deine erste Zigarette?',
                '$_firstCigaretteTime Uhr',
                PickerType.firstCigaretteTime,
                1,
                theme,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildPickerButton(
                context,
                themeProvider,
                'Deine letzte Zigarette?',
                '$_lastCigaretteTime Uhr',
                PickerType.lastCigaretteTime,
                2,
                theme,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Erstellen der Fragen für Morgen, Tagsüber, Abend
  Widget _buildMorningAfternoonEveningCigarettesRow(
      BuildContext context, ThemeProvider themeProvider, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildPickerButton(
                context,
                themeProvider,
                'Morgens?',
                '$_morningCigarettes',
                PickerType.morningCigarettes,
                3,
                theme,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildPickerButton(
                context,
                themeProvider,
                'Tagsüber?',
                '$_afternoonCigarettes',
                PickerType.afternoonCigarettes,
                4,
                theme,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildPickerButton(
                context,
                themeProvider,
                'Abends?',
                '$_eveningCigarettes',
                PickerType.eveningCigarettes,
                5,
                theme,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Erstellen der Auswahl
  Widget _buildOptionsWrap(ThemeData theme) {
    return Wrap(
      spacing: 10.0, // Abstand zwischen den Containern
      runSpacing: 10.0, // Abstand zwischen den Reihen
      children: [
        OptionCard(
          headline: 'SCHNELL & HART',
          imageUrl: 'assets/images/sprinten.jpg',
          descriptionLine1:
              'Der Weg beginnt mit dem schnellen Beenden des Rauchens, gefolgt von einer strikten Vermeidung von Situationen und Auslösern, die den Drang zum Rauchen auslösen könnte.',
          descriptionLine2: 'Deine Erfolgsquote: 64 %',
          successRate: 0.64,
          onSelect: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Option1Page()),
            );
          },
        ),
        OptionCard(
          headline: 'AUSGEWOGEN',
          imageUrl: 'assets/images/medium.jpg',
          descriptionLine1:
              'Ein ausgewogener Ansatz zum Aufhören beinhaltet, das Rauchen allmählich zu reduzieren und gleichzeitig bewusst gesunde Gewohnheiten zu etablieren.',
          descriptionLine2: 'Deine Erfolgsquote: 78 % %',
          successRate: 0.78,
          onSelect: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Option2Page()),
            );
          },
        ),
        OptionCard(
          headline: 'LANGSAM ABBAUEND',
          imageUrl: 'assets/images/gehen.jpg',
          descriptionLine1:
              'Bietet den sanftesten Übergang zu einem rauchfreien Leben. Indem du die Anzahl der Zigaretten schrittweise reduzierst, gibst du deinem Körper die Zeit, sich anzupassen, und baust gleichzeitig neue, gesunde Gewohnheiten auf,',
          descriptionLine2: 'Deine Erfolgsquote: 92 %',
          successRate: 0.92,
          onSelect: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Option3Page()),
            );
          },
        ),
      ],
    );
  }

  // Anzeige des Pickers nach Typ
  void _showPicker(BuildContext context, PickerType pickerType) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    int remainingCigarettes = _selectedCigarettes -
        (_morningCigarettes + _afternoonCigarettes + _eveningCigarettes);

    Picker picker;
    switch (pickerType) {
      case PickerType.cigarettes:
        picker = Picker(
          adapter: NumberPickerAdapter(data: [
            const NumberPickerColumn(begin: 1, end: 60),
          ]),
          selecteds: [_selectedCigarettes - 1],
          hideHeader: true,
          textStyle: themeProvider.currentTheme.textTheme.bodyLarge,
          onConfirm: (Picker picker, List<int> value) {
            setState(() {
              _selectedCigarettes = value.first + 1;
              _currentStep = 1;
            });
          },
        );
        break;
      case PickerType.firstCigaretteTime:
      case PickerType.lastCigaretteTime:
        picker = Picker(
          adapter: DateTimePickerAdapter(
            type: PickerDateTimeType.kHM,
            isNumberMonth: true,
            yearBegin: 2024,
            yearEnd: 2025,
            minuteInterval: 5,
            value: pickerType == PickerType.firstCigaretteTime
                ? DateTime(
                    2024,
                    1,
                    1,
                    int.parse(_firstCigaretteTime.split(':')[0]),
                    int.parse(_firstCigaretteTime.split(':')[1]))
                : DateTime(
                    2024,
                    1,
                    1,
                    int.parse(_lastCigaretteTime.split(':')[0]),
                    int.parse(_lastCigaretteTime.split(':')[1])),
          ),
          hideHeader: true,
          textStyle: themeProvider.currentTheme.textTheme.bodyLarge,
          onConfirm: (Picker picker, List<int> value) {
            setState(() {
              final time = (picker.adapter as DateTimePickerAdapter).value;
              if (pickerType == PickerType.firstCigaretteTime) {
                _firstCigaretteTime =
                    '${time?.hour.toString().padLeft(2, '0')}:${time?.minute.toString().padLeft(2, '0')}';
                _currentStep = 2;
              } else {
                _lastCigaretteTime =
                    '${time?.hour.toString().padLeft(2, '0')}:${time?.minute.toString().padLeft(2, '0')}';
                _currentStep = 3;
              }
            });
          },
        );
        break;
      case PickerType.morningCigarettes:
        picker = Picker(
          adapter: NumberPickerAdapter(data: [
            NumberPickerColumn(begin: 0, end: _selectedCigarettes),
          ]),
          selecteds: [_morningCigarettes],
          hideHeader: true,
          textStyle: themeProvider.currentTheme.textTheme.bodyLarge,
          onConfirm: (Picker picker, List<int> value) {
            setState(() {
              _morningCigarettes = value.first;
              _currentStep = 4;
            });
          },
        );
        break;
      case PickerType.afternoonCigarettes:
        picker = Picker(
          adapter: NumberPickerAdapter(data: [
            NumberPickerColumn(begin: 0, end: remainingCigarettes),
          ]),
          selecteds: [_afternoonCigarettes],
          hideHeader: true,
          textStyle: themeProvider.currentTheme.textTheme.bodyLarge,
          onConfirm: (Picker picker, List<int> value) {
            setState(() {
              _afternoonCigarettes = value.first;
              _currentStep = 5;
            });
          },
        );
        break;
      case PickerType.eveningCigarettes:
        picker = Picker(
          adapter: NumberPickerAdapter(data: [
            NumberPickerColumn(begin: 0, end: remainingCigarettes),
          ]),
          selecteds: [_eveningCigarettes],
          hideHeader: true,
          textStyle: themeProvider.currentTheme.textTheme.bodyLarge,
          onConfirm: (Picker picker, List<int> value) {
            setState(() {
              _eveningCigarettes = value.first;
              _currentStep = 6;
              _showProgress = true;
              _startProgressBar();
            });
          },
        );
        break;
      default:
        picker = Picker(
          adapter: NumberPickerAdapter(data: [
            const NumberPickerColumn(begin: 0, end: 0),
          ]),
          hideHeader: true,
          textStyle: themeProvider.currentTheme.textTheme.bodyLarge,
        );
        break;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: themeProvider.currentTheme.colorScheme.surface,
          contentPadding: const EdgeInsets.all(6.0),
          content: SizedBox(
            width: 250,
            height: 250,
            child: picker.makePicker(),
          ),
          actions: [
            TextButton(
              child: Text(
                'Abbrechen',
                style: themeProvider.currentTheme.textTheme.labelLarge,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Bestätigen',
                style: themeProvider.currentTheme.textTheme.labelLarge,
              ),
              onPressed: () {
                picker.onConfirm?.call(picker, picker.selecteds);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Starten des Fortschrittsbalkens
  void _startProgressBar() {
    setState(() {
      _progressValue = 0.0;
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      for (int i = 0; i <= 100; i++) {
        Future.delayed(Duration(milliseconds: 50 * i), () {
          setState(() {
            _progressValue = i / 100;
            if (i == 100) {
              _showProgress = false;
              _calculationComplete = true;
              _saveSmokingData(); // Hier Daten speichern
            }
          });
        });
      }
    });
  }

  // Speichern der Daten in der Datenbank
  void _saveSmokingData() async {
    SmokingData data = SmokingData(
      selectedCigarettes: _selectedCigarettes,
      firstCigaretteTime: _firstCigaretteTime,
      lastCigaretteTime: _lastCigaretteTime,
      morningCigarettes: _morningCigarettes,
      afternoonCigarettes: _afternoonCigarettes,
      eveningCigarettes: _eveningCigarettes,
    );

    await DatabaseHelper.instance.upsertSmokingData(data);
  }
}
