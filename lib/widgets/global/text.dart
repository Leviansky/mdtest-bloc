import 'package:flutter/material.dart';

class GText {
  static Text title(String text, {TextAlign? align}) => Text(
    text,
    textAlign: align,
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      height: 1.1,
    ),
  );

  static Text subtitle(String text, {TextAlign? align}) => Text(
    text,
    textAlign: align,
    style: const TextStyle(
      fontSize: 13,
      color: Color(0xFF6B7280),
      height: 1.25,
    ),
  );

  static Text footnote(String text, {TextAlign? align}) => Text(
    text,
    textAlign: align,
    style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280), height: 1.3),
  );
}
