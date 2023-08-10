import 'package:flutter/material.dart';

const Color _customColor = Color(0xFF1D5B79);
const Color _customColor2 = Color(0xFF89fc00);

const List<Color> _colorThemes = [
  _customColor,
  _customColor2,
  Colors.blueAccent,
  Colors.indigo,
  Colors.pink,
  Colors.orange
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0})
      : assert(selectedColor >= 0 && selectedColor <= _colorThemes.length - 1,
            'Colors must be between 0 and ${_colorThemes.length}');

  ThemeData theme() {
    return ThemeData(
        useMaterial3: true, colorSchemeSeed: _colorThemes[selectedColor]);
  }
}
