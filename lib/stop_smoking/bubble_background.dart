import 'package:flutter/material.dart';
import 'package:floating_bubbles/floating_bubbles.dart';

class BubbleBackground extends StatelessWidget {
  final Color? backgroundColor;
  final int noOfBubbles;
  final List<Color>? colorsOfBubbles;
  final double sizeFactor;
  final int duration;
  final int opacity;
  final double strokeWidth;
  final BubbleShape shape;
  final BubbleSpeed speed;

  const BubbleBackground({
    super.key,
    this.backgroundColor,
    this.noOfBubbles = 25,
    this.colorsOfBubbles,
    this.sizeFactor = 0.26,
    this.duration = 120,
    this.opacity = 40,
    this.strokeWidth = 20,
    this.shape = BubbleShape.circle,
    this.speed = BubbleSpeed.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: backgroundColor ?? Theme.of(context).primaryColorLight,
          ),
        ),
        Positioned.fill(
          child: FloatingBubbles(
            noOfBubbles: noOfBubbles,
            colorsOfBubbles: colorsOfBubbles ??
                [
                  Theme.of(context).colorScheme.tertiaryContainer.withAlpha(30),
                  Theme.of(context).colorScheme.tertiaryFixedDim,
                ],
            sizeFactor: sizeFactor,
            duration: duration,
            opacity: opacity,
            paintingStyle: PaintingStyle.fill,
            strokeWidth: strokeWidth,
            shape: shape,
            speed: speed,
          ),
        ),
      ],
    );
  }
}
