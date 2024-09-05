import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informationen'),
        backgroundColor: Colors.teal, // Farbgebung passend zur App
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Über diese App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              'Mit "Meet Your Colleague" können Sie einfach und schnell Kontakt zu '
              'Ihren Kollegen aufnehmen. Die App ermöglicht es, zufällig einen Kollegen '
              'auszuwählen und direkt einen Anruf zu starten. Die Funktion ist'
              'wegen fehlender Daten im \'person_repository.dart\' momentan nicht freigeschaltet ',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            const Text(
              'Betriebssystem-Auswahl:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Column(
              children: [
                const SizedBox(height: 5),
                const Text(
                  'Je nach verwendetem Betriebssystem (Android oder iOS) öffnet die App '
                  'unterschiedliche Anwendungen, um Anrufe zu tätigen. Für Android-Nutzer '
                  'wird Google Meet genutzt, während iOS-Nutzer Facetime verwenden.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                Image.asset(
                  'assets/images/googleMeet.jpg', // Pfad zum Bild
                  height: 400, // Optional: Höhe des Bildes anpassen
                  width: 150, // Optional: Breite des Bildes anpassen
                  fit: BoxFit.contain, // Optional: Wie das Bild skaliert wird
                ),
                const SizedBox(height: 5),
                Image.asset(
                  'assets/images/facetime.jpg', // Pfad zum Bild
                  height: 400, // Optional: Höhe des Bildes anpassen
                  width: 150, // Optional: Breite des Bildes anpassen
                  fit: BoxFit.contain, // Optional: Wie das Bild skaliert wird
                ),
                const SizedBox(height: 5),
                const Text(
                  'Anruf starten:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  '1. Wählen Sie "Select Colleague", um zufällig einen Kollegen aus der Liste auszuwählen.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                const Text(
                  '2. Drücken Sie auf "Verbinden", um einen Anruf mit dem ausgewählten Kollegen '
                  'zu starten. Die App prüft automatisch, ob die Telefonnummer eine deutsche '
                  'Mobilfunknummer ist.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Überprüfungen und Fehlermeldungen:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  '- **isGermanMobilePhoneNumber()**: Diese Funktion prüft, ob die Telefonnummer '
                  'eine gültige deutsche Mobilfunknummer ist. Nur gültige Nummern können für '
                  'Anrufe verwendet werden.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                const Text(
                  '- **Keine Telefonnummer vorhanden**: Wenn ein Kollege keine Telefonnummer hinterlegt '
                  'hat, erhalten Sie eine entsprechende Benachrichtigung.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                const Text(
                  '- **App nicht installiert**: Falls die erforderliche App (z.B. Google Meet) nicht '
                  'installiert ist, werden Sie aufgefordert, diese zu installieren.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                Image.asset(
                  'assets/images/nicht_installiert.jpg', // Pfad zum Bild
                  height: 400, // Optional: Höhe des Bildes anpassen
                  width: 150, // Optional: Breite des Bildes anpassen
                  fit: BoxFit.contain, // Optional: Wie das Bild skaliert wird
                ),
                const SizedBox(height: 5),
                const Text(
                  'Fehlermeldungen:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  '- Wenn ein Anruf nicht gestartet werden kann, erscheint eine Fehlermeldung mit der '
                  'Aufforderung, die App zu überprüfen oder zu installieren.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                Image.asset(
                  'assets/images/googleSignIn.jpg', // Pfad zum Bild
                  height: 400, // Optional: Höhe des Bildes anpassen
                  width: 150, // Optional: Breite des Bildes anpassen
                  fit: BoxFit.contain, // Optional: Wie das Bild skaliert wird
                ),
                const SizedBox(height: 5),
                const Text(
                  '- Sollte die gewählte Person keine Telefonnummer haben, wird dies ebenfalls durch '
                  'eine Meldung angezeigt.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                Image.asset(
                  'assets/images/keineTelefonnummer.jpg', // Pfad zum Bild
                  height: 400, // Optional: Höhe des Bildes anpassen
                  width: 150, // Optional: Breite des Bildes anpassen
                  fit: BoxFit.contain, // Optional: Wie das Bild skaliert wird
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
