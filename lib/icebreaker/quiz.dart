import 'package:flutter/material.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions; // Fragenliste
  final int questionIndex; // Fragenindex
  final void Function(int, bool, int, String) answerQuestion; // Antwortfunktion
  final List<Color> buttonColors; // Farbangabe der Button

  const Quiz({
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
    required this.buttonColors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final answers =
        questions[questionIndex]['answers'] as List<Map<String, Object>>;

    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 150,
          alignment: Alignment.center,
          child: Text(
            questions[questionIndex]['questionText'] as String,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: answers.asMap().entries.map((entry) {
                final index = entry.key; // Dies ist der Index der Antwort
                final answer =
                    entry.value; // Dies ist die Antwort selbst als Map
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor:
                            buttonColors[index], // verwendet den index
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 25),
                        textStyle: const TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadowColor: Colors.blueAccent,
                        elevation: 5,
                      ),
                      child: Text(answer['text']
                          as String), // verwendet answer, um Text anzuzeigen
                      onPressed: () => answerQuestion(
                        answer['points']
                            as int, // verwendet answer, um Punkte zu übergeben
                        answer['wahr']
                            as bool, // verwendet answer, um Boolean zu übergeben
                        index, // verwendet index, um den Antwortindex zu übergeben
                        answer['snackText']
                            as String, // verwendet answer, um SnackBartext zu übergeben
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

/*import 'package:flutter/material.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions; // Fragenliste
  final int questionIndex; // Fragenindex
  final void Function(int, bool, int, String) answerQuestion; // Antwortfunktion
  final List<Color> buttonColors; // Farbangabe der Button

  const Quiz({
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
    required this.buttonColors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final answers =
        questions[questionIndex]['answers'] as List<Map<String, Object>>;
    return SingleChildScrollView(
      // Sicherung gegen Flex-Overflow
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 150,
            alignment: Alignment.center,
            child: Text(
              questions[questionIndex]['questionText']
                  as String, // Anzeige der aktuellen Frage
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          // Erzeugt die Antwort-Buttons
          ...answers.asMap().entries.map((entry) {
            final index = entry.key;
            final answer = entry.value;
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: buttonColors[
                        index], // setzt die Buttonfarbe true - false
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 25),
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadowColor: Colors.blueAccent,
                    elevation: 5,
                  ),
                  child: Text(answer['text'] as String), // Antworttext
                  onPressed: () => answerQuestion(
                    answer['points'] as int, // Punkte für die Antwort
                    answer['wahr'] as bool, // Antwort true - false
                    index, // Antwortindex
                    answer['snackText'] as String, // SnackBartext
                  ),
                ),
              ),
            );
          }).toList(),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
*/
