import 'package:flutter/material.dart';

class ProgressWidget extends StatelessWidget {
  final double progress;

  // Konstruktor zur Initialisierung des Fortschrittswertes
  const ProgressWidget({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _getProgressIndicator(progress),
    );
  }

  // Erzeugt die Fortschrittsanzeige
  Widget _getProgressIndicator(double progress) {
    return Container(
      width: 70.0,
      height: 70.0,
      padding: const EdgeInsets.all(8.0),
      decoration:
          const BoxDecoration(color: Colors.teal, shape: BoxShape.circle),
      child: Stack(alignment: Alignment.center, children: [
        Positioned.fill(
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 4.0,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        Text(
          "${(progress * 100).toInt()}%",
          style: const TextStyle(
              fontSize: 13.0, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ]),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Progress Indicator')),
      body: const ProgressWidget(progress: 0.7),
    ),
  ));
}
