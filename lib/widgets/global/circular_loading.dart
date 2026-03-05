import 'package:flutter/material.dart';

class GCircularLoading extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color color;

  const GCircularLoading({
    super.key,
    this.size = 20,
    this.strokeWidth = 2,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(strokeWidth: strokeWidth, color: color),
    );
  }
}
