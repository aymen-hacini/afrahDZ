import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Gradient gradient;

  const GradientText({
    super.key,
    required this.text,
    this.style,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn, // Ensures the gradient is applied to the text
      shaderCallback: (bounds) {
        return gradient.createShader(bounds);
      },
      child: Text(
        text,
        style:
            style?.copyWith(color: Colors.white), // Use white as the base color
      ),
    );
  }
}
