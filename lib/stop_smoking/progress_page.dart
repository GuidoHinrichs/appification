import 'package:flutter/material.dart';
import 'database_helper.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dein Fortschritt')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        // asynchrones Laden der Fortschrittsdaten aus der Datenbank
        future: DatabaseHelper.instance
            .getProgressData(), // Abrufen der Fortschrittsdaten
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Ladeindikator
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            // Fehlerbehandlung
            return const Center(child: Text('Fehler beim Laden der Daten.'));
          }

          final data = snapshot.data;

          if (data == null || data.isEmpty) {
            // Fehlerbehandlung
            return const Center(child: Text('Keine Daten vorhanden.'));
          }

          // Erstellen der Listeneinträge
          return ListView.builder(
            itemCount: data.length, // Anzahl der Listeneinträge
            itemBuilder: (context, index) {
              final entry = data[index]; // Datensatz für aktuelle Zeile

              // ListTile für jeden Eintrag in der Liste
              return ListTile(
                title: Text('Datum: ${entry['date']}'), // Datum Fortschritt
                subtitle: Text(
                    'Zigaretten übrig: ${entry['cigarettes_remaining']}'), // Anzahl übrig gebliebene Zigaretten
                trailing: Text(entry['method']), // Berechnung des Fortschritts
              );
            },
          );
        },
      ),
    );
  }
}
