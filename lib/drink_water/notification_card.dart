import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/theme_provider.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;

  const NotificationCard(
      {super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    // Zugriff auf das aktuelle Theme
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = themeProvider.currentTheme;

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent, // Hintergrundfarbe auf hellblau setzen
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Icon
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: const Icon(
              Icons.local_drink, // Beispiel-Icon
              size: 30.0,
              color: Colors
                  .white, // Farbe des Icons auf weiß setzen, damit es besser zu hellblau passt
            ),
          ),

          // Benachrichtigungsdetails
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize
                  .min, // Wichtig: Reduziert die Höhe der Column auf das Minimum
              children: <Widget>[
                // Titel
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5.0),

                // Nachrichtentext
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationList extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {"title": "Erinnerung", "message": "Trinke ein Glas Wasser."},
    {
      "title": "Hydrations-Check",
      "message":
          "Zeit für einen Schluck Wasser! Dein Körper wird es dir danken."
    },
    {
      "title": "Gesundheitstipp",
      "message":
          "Vergiss nicht, ausreichend zu trinken. Ein Glas Wasser hilft immer!"
    },
    {
      "title": "Erinnerung",
      "message": "Denke daran, regelmäßig Wasser zu trinken. Bleibe hydriert!"
    },
    {
      "title": "Trinkpause",
      "message": "Gönn dir eine kurze Pause und trinke ein Glas Wasser!"
    },
    {
      "title": "Bleib fit!",
      "message":
          "Ein Schluck Wasser erfrischt nicht nur, sondern hält dich auch fit. Trinke jetzt!"
    },
    {
      "title": "Gesunde Gewohnheiten",
      "message":
          "Wasser ist lebenswichtig! Trinke jetzt ein Glas, um gesund zu bleiben."
    },
    {
      "title": "Deine tägliche Hydration",
      "message": "Denke daran, Wasser zu trinken. Dein Körper braucht es!"
    },
    {
      "title": "Zeit für Wasser",
      "message": "Es ist Zeit für eine Erfrischung! Trinke ein Glas Wasser."
    },
    {
      "title": "Stay Hydrated",
      "message":
          "Ein gesundes Leben beginnt mit einem Glas Wasser. Trinke jetzt!"
    },
    {
      "title": "Wasserpause",
      "message":
          "Kleine Erinnerung: Trinke regelmäßig Wasser, um hydratisiert zu bleiben!"
    }
  ];

  NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Hintergrundfarbe auf weiß setzen
      appBar: AppBar(
        title: const Text(
          'Push Notifications',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      /*appBar: AppBar(
        title: Text('Benachrichtigungen'),
        backgroundColor: Theme.of(context).primaryColor, // Verwende die Primärfarbe des Themes
      ),*/
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return NotificationCard(
                  title: notifications[index]["title"]!,
                  message: notifications[index]["message"]!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
