import 'package:flutter/material.dart';

class ColorConstants {
  // Primary Colors
  static const Color primary = Color(0xFF1ED760);
  static const Color primaryDark = Color(0xFF1DB954);
  static const Color background = Color(0xFF0A1410);
  static const Color surface = Color(0xFF1B2B25);
  static const Color surfaceVariant = Color(0xFF243530);
  
  // Text Colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white60;
  static const Color textOnPrimary = Colors.black;
  static const Color textHint = Colors.white54;
  
  // State Colors
  static const Color success = Colors.green;
  static const Color error = Colors.red;
  static const Color warning = Colors.orange;
  static const Color info = Colors.blue;
  
  // Utility Colors
  static const Color transparent = Colors.transparent;
  static const Color shadow = Colors.black26;
  static const Color disabled = Colors.grey;
  static const Color divider = Colors.white12;
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [background, surface],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}