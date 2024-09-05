import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final String headline;
  final String imageUrl;
  final String descriptionLine1;
  final String descriptionLine2;
  final double successRate;
  final VoidCallback onSelect;

  const OptionCard({
    Key? key,
    required this.headline,
    required this.imageUrl,
    required this.descriptionLine1,
    required this.descriptionLine2,
    required this.successRate,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            headline,
            style: theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Image.asset(
            imageUrl,
            width: 100,
            height: 150,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          Text(
            descriptionLine1,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            descriptionLine2,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 16, // Schriftgröße auf 14px setzen
              fontWeight: FontWeight.bold, // Text fett machen
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: successRate,
            minHeight: 10,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            valueColor:
                AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: onSelect,
            child: const Text('Auswählen'),
          ),
        ],
      ),
    );
  }
}
