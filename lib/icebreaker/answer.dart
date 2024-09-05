import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final void Function() selectHandler;
  final String answerText;
  final Color buttonColor;

  const Answer({
    required this.selectHandler,
    required this.answerText,
    required this.buttonColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // Expanded hier ist sinnvoll, weil es in einem Column verwendet wird
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: buttonColor,
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height > 800 ? 35 : 25,
              ),
              textStyle: const TextStyle(fontSize: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadowColor: Colors.blueAccent,
              elevation: 5,
            ),
            onPressed: selectHandler,
            child: Text(
              answerText,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
