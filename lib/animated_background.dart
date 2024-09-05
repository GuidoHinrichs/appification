import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  // AnimationController steuert die Animation
  late AnimationController _controller;
  late Animation<Color?> _color1;
  late Animation<Color?> _color2;

  @override
  void initState() {
    super.initState();
    // Initialisierung des AnimationControllers
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    // Initialisierung der ColorTween-Animationen mit zufälligen Farben
    _color1 = ColorTween(
      begin: _randomColor(),
      end: _randomColor(),
    ).animate(_controller);

    _color2 = ColorTween(
      begin: _randomColor(),
      end: _randomColor(),
    ).animate(_controller);
  }

  @override
  void dispose() {
    // Ressourcen freigeben, wenn der Widget-Baum entfernt wird
    _controller.dispose();
    super.dispose();
  }

  // Zufällige Farbe erzeugen
  Color _randomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    // AnimatedBuilder um Animation auf Container-Widget anzuwenden
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: double.infinity, // Stellt sicher, dass die Breite 100% beträgt
          height: double.infinity, // Stellt sicher, dass die Höhe 100% beträgt
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _color1.value ?? Colors.black12,
                _color2.value ?? Colors.blueGrey,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );
      },
    );
  }
}
