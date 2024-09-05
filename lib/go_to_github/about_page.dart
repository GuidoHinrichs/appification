import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  final String githubUrl = 'https://github.com/yourusername/yourrepository';

  const AboutPage({super.key});

  Future<void> _launchURL() async {
    if (await canLaunchUrl(Uri.parse(githubUrl))) {
      await launchUrl(Uri.parse(githubUrl));
    } else {
      throw 'Could not launch $githubUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('path to GitHub'),
        iconTheme: const IconThemeData(
          color: Colors.white, // Farbe für den "Zurück"-Pfeil setzen
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Dein Weg zu meinem GitHub repository:'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _launchURL,
              child: const Text('Visit GitHub'),
            ),
          ],
        ),
      ),
    );
  }
}
