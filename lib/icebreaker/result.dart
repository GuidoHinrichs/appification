import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalPoints; // Gesamtpunkte
  final VoidCallback resetQuiz; // Zurücksetzen des Quizzes
  final VoidCallback? continuePlaying; // Zweite Runde spielen
  final bool isFirstRound; // Abfrage, welche Runde

  const Result(this.totalPoints, this.resetQuiz, this.continuePlaying,
      {super.key, required this.isFirstRound});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Du hast $totalPoints Punkte erreicht!', // Anzeige der erspielten Punkte
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          if (isFirstRound) ...[
            // Zurücksetzen oder Weiterspielen, wenn Runde 1
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: resetQuiz, // Quizz zurücksetzen
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black45,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadowColor: Colors.blueAccent,
                  elevation: 5,
                ),
                child: const Text('Nochmal spielen'),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: continuePlaying, // Start Runde 2
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xff00687a),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadowColor: Colors.blueAccent,
                  elevation: 5,
                ),
                child: const Text('Weiterspielen'),
              ),
            ),
          ] else ...[
            // Zurücksetzen, wenn nicht Runde 1
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: resetQuiz,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black45,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadowColor: Colors.blueAccent,
                  elevation: 5,
                ),
                child: const Text('Nochmal spielen'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
