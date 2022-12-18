import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ColorModel extends Equatable {
  final Color background;
  Color text;
  bool isDark;

  ColorModel({
    required this.background,
    required this.text,
    required this.isDark,
  });

  void changeDarkerMode() {
    if (text == Colors.white) {
      text = Colors.black;
    } else if (text == Colors.black) {
      text = Colors.white;
    }
    isDark = !isDark;
  }

  @override
  List<Object?> get props => [background, text];
}
