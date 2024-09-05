import 'package:flutter/material.dart';
import 'quiz.dart';
import 'result.dart';
import 'question_storage.dart';
import 'question_storage_II.dart';
import 'info_screen_ib.dart';

class Icebreaker extends StatefulWidget {
  const Icebreaker({super.key});

  @override
  State<StatefulWidget> createState() {
    return _IcebreakerState();
  }
}

class _IcebreakerState extends State<Icebreaker> {
  var _questionIndex = 0; // Index aktuelle Frage
  var _totalPoints = 0; // Punkte des Spielers
  var _isFirstRound = true; // Abfrage erste Runde
  late List<Color> _buttonColors; // Farben Antwort-Buttons

  @override
  void initState() {
    super.initState();
    _initializeButtonColors(); // Buttonfarbe initialisieren
  }

  void _initializeButtonColors() {
    final answers = (_isFirstRound ? questions : questionsII)[_questionIndex]
        ['answers'] as List<Map<String, Object>>;
    _buttonColors =
        List.filled(answers.length, const Color(0xff00687a)); // Standardfarbe
  }

  void _answerQuestion(
      int points, bool isCorrect, int answerIndex, String snackText) {
    // Aufruf, wenn Antwort ausgewählt
    setState(() {
      _buttonColors[answerIndex] =
          isCorrect ? Colors.green : Colors.red; // Setzt Farbe true - false
      _totalPoints += points; // Addiert Punkte

      // Feedback in SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 1,
                color: Colors.white,
              ),
              const SizedBox(height: 4),
              Text(snackText, textAlign: TextAlign.center),
            ],
          ),
          backgroundColor: const Color(0xff00687a),
          duration: const Duration(seconds: 2),
        ),
      );

      // Verzögerung bis zur nächsten Frage
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _questionIndex = _questionIndex + 1; // Gehe zur nächsten Frage
          if (_questionIndex <
              (_isFirstRound ? questions : questionsII).length) {
            _initializeButtonColors();
          }
        });
      });
    });
  }

  void _resetQuiz() {
    // Setzt das Quizz zurück
    setState(() {
      _questionIndex = 0;
      _totalPoints = 0;
      _isFirstRound = true;
      _initializeButtonColors();
    });
  }

  void _continuePlaying() {
    // Startet Runde 2
    setState(() {
      _questionIndex = 0;
      _isFirstRound = false;
      _initializeButtonColors();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Icebreaker'),
        backgroundColor: const Color(0xff00687a),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InfoScreenIcebreaker(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffffffff),
              Color(0xff00687a)
            ], // Hintergrund Farbverlauf
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          // Hier verwenden wir Column
          mainAxisAlignment: MainAxisAlignment.center,
          // Zentriere den Inhalt vertikal
          children: [
            Expanded(
              child: _questionIndex <
                      (_isFirstRound ? questions : questionsII).length
                  ? Quiz(
                      answerQuestion: _answerQuestion,
                      questionIndex: _questionIndex,
                      questions: _isFirstRound ? questions : questionsII,
                      buttonColors: _buttonColors,
                    )
                  : Result(
                      _totalPoints,
                      _resetQuiz,
                      _isFirstRound ? _continuePlaying : null,
                      isFirstRound: _isFirstRound,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
