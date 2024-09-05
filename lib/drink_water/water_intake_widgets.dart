import 'package:flutter/material.dart';

class WaterIntakeWidgets extends StatelessWidget {
  final ThemeData theme;
  final int selectedWeight;
  final Function(double) onWeightChanged;
  final int selectedAge;
  final Function(double) onAgeChanged;
  final String userName;
  final bool isNameEditable;
  final Function(String) onNameChanged;
  final Function() onToggleNameEdit;
  final String locationName;
  final double temperature;
  final List<String> activityLevels;
  final String selectedActivityLevel;
  final Function(String) onActivityLevelChanged;
  final String activityDescription;
  final Function() onShowInfoDialog;

  const WaterIntakeWidgets({
    super.key,
    required this.theme,
    required this.selectedWeight,
    required this.onWeightChanged,
    required this.selectedAge,
    required this.onAgeChanged,
    required this.userName,
    required this.isNameEditable,
    required this.onNameChanged,
    required this.onToggleNameEdit,
    required this.locationName,
    required this.temperature,
    required this.activityLevels,
    required this.selectedActivityLevel,
    required this.onActivityLevelChanged,
    required this.activityDescription,
    required this.onShowInfoDialog,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        _buildInfoRow('Die richtige Trinkmenge', () {
                          onShowInfoDialog();
                        }),
                        _buildInfoRow('Was, wenn ich zu wenig trinke?', () {
                          onShowInfoDialog();
                        }),
                        _buildInfoRow('Was kann ich trinken?', () {
                          onShowInfoDialog();
                        }),
                        _buildInfoRow('Trinkmuffel? Diese Tipps helfen', () {
                          onShowInfoDialog();
                        }),
                        _buildInfoRow('Wasser kann man auch essen', () {
                          onShowInfoDialog();
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildWeightSlider(),
                  const SizedBox(height: 20),
                  _buildAgeSlider(),
                  const SizedBox(height: 20),
                  _buildUserNameInput(),
                  const SizedBox(height: 20),
                  _buildTemperatureDisplay(),
                  const SizedBox(height: 20),
                  _buildActivityLevelSelector(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String title, VoidCallback onPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(color: theme.colorScheme.onSurface, fontSize: 16.0),
        ),
        IconButton(
          icon: Icon(Icons.info, color: theme.colorScheme.onSurface),
          onPressed: onPressed,
        ),
      ],
    );
  }

  Widget _buildWeightSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              '$selectedWeight kg',
              style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const Text('120 kg'),
          ],
        ),
        Slider(
          value: selectedWeight.toDouble(),
          min: 45,
          max: 120,
          divisions: 75,
          label: '$selectedWeight kg',
          onChanged: onWeightChanged,
        ),
      ],
    );
  }

  Widget _buildAgeSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              '$selectedAge Jahre',
              style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const Text('85 Jahre'),
          ],
        ),
        Slider(
          value: selectedAge.toDouble(),
          min: 18,
          max: 85,
          divisions: 87,
          label: '$selectedAge Jahre',
          onChanged: onAgeChanged,
        ),
      ],
    );
  }

  Widget _buildUserNameInput() {
    return isNameEditable
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
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: onNameChanged,
                  ),
                ),
              ),
            ],
          )
        : Column(
            children: [
              Text(
                'Hallo $userName',
                style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: onToggleNameEdit,
                  child: const Text('Benutzer wechseln'),
                ),
              ),
            ],
          );
  }

  Widget _buildTemperatureDisplay() {
    return Center(
      child: Text(
        'Aktuelle Temperatur in $locationName: ${temperature.toStringAsFixed(1)} °C',
        style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildActivityLevelSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aktivitätsniveau',
          style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: activityLevels
                  .map((level) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ChoiceChip(
                          label: Text(level),
                          selected: selectedActivityLevel == level,
                          onSelected: (bool selected) {
                            onActivityLevelChanged(
                                selected ? level : selectedActivityLevel);
                          },
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
        if (selectedActivityLevel.isNotEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                activityDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 16,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
