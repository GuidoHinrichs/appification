import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'animated_background.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  double _opacity = 1.0; // Initial opacity set to fully visible

  @override
  void initState() {
    super.initState();

    // Start the fade-out after 6 seconds
    Timer(const Duration(seconds: 6), () {
      setState(() {
        _opacity = 0.0; // Set opacity to 0 for fade-out effect
      });

      // Navigate to the main screen after the fade-out completes
      Timer(const Duration(seconds: 2), () {
        Navigator.of(context).pushReplacementNamed('/home');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: AnimatedBackground(),
          ),
          AnimatedOpacity(
            opacity: _opacity, // Apply opacity value
            duration: const Duration(seconds: 2), // Duration of fade-out
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context)
                    .size
                    .height, // Ensures the container takes full screen height
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.flutter_dash,
                        size: 70, color: Colors.white),
                    const SizedBox(height: 20),
                    Text(
                      'Guido Hinrichs',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    DefaultTextStyle(
                      style: GoogleFonts.permanentMarker(
                        textStyle: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(
                            'Happy Work Spaces',
                            speed: const Duration(milliseconds: 200),
                          ),
                        ],
                        isRepeatingAnimation: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
