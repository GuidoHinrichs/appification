import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'person.dart';

// Klasse für das initiieren von Video-Call/Anruf
class CallHandler {
  // Build-Kontext für den Zugriff auf Flutter-Funktionen
  late final BuildContext context;

  // Konstruktor der CallHandler-Klasse
  CallHandler(this.context);

  bool _isGermanMobilePhoneNumber(String phoneNumber) {
    // Überprüfen, ob Telefonnummer deutsche Mobilnummer ist
    return (phoneNumber.startsWith('01')) ||
        (phoneNumber.startsWith('+491')) ||
        (phoneNumber.startsWith('00'));
  }

  // Methode zum Initiieren von Video-Call/Anruf zu der ausgewählten Person
  Future<void> makeCall(Person person) async {
    String phoneNumber = person.phone;

    // Telefonnummer der ausgewählten Person
    if (phoneNumber.isNotEmpty) {
      if (_isGermanMobilePhoneNumber(phoneNumber)) {
        String url = '';
        if (defaultTargetPlatform == TargetPlatform.android) {
          url = 'https://meet.google.com/call/$phoneNumber';
        } else if (defaultTargetPlatform == TargetPlatform.iOS) {
          url = 'facetime:$phoneNumber';
        }
        if (url.isNotEmpty) {
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url));
          } else {
            // Plattform unterstützt die URI nicht
            _showInstallAppDialog();
          }
        } else if (phoneNumber.isNotEmpty) {
          _makePhoneCall(phoneNumber);
        }
        // Anzeige des Dialogs bei fehlender Telefonnummer
        else {
          _showNoPhoneNumberDialog();
        }
      }
    }
  }

  // Diese Methode startet einen Telefonanruf mit der angegebenen Telefonnummer.
  void _makePhoneCall(String phoneNumber) async {
    String telUri = 'tel:$phoneNumber';
    if (await canLaunchUrl(Uri.parse(telUri))) {
      await launchUrl(Uri.parse(telUri));
    } else {
      throw 'Anruf konnte nicht gestartet werden.';
    }
  }

  // Diese Methode zeigt einen Dialog an, der den Benutzer auffordert, die erforderliche App zu installieren.
  Future<void> _showInstallAppDialog() async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('App nicht installiert'),
        content: const Text('Bitte installiere die erforderliche App.'),
        actions: [
          TextButton(
            onPressed: () async {
              final Uri url = Uri.parse(
                  'https://play.google.com/store/apps/details?id=com.google.android.apps.meetings');
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                throw 'Seite kann nicht geöffnet werden.';
              }
            },
            child: const Text('App installieren'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Abbrechen'),
          ),
        ],
      ),
    );
  }

  // Diese Methode zeigt einen Dialog an, wenn die ausgewählte Person keine Telefonnummer hinterlegt hat.
  void _showNoPhoneNumberDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Keine Telefonnummer vorhanden'),
        content: const Text(
            'Die gewählte Person hat keine Telefonnummer hinterlegt.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  canLaunchUrl(Uri parse) {}

  launchUrl(Uri parse) {}
}
