import 'package:flutter/material.dart';
import 'color_constants.dart';
import 'spacing_constants.dart';
import 'app_constants.dart';

class StyleConstants {
  // Text Styles
  static const TextStyle titleLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: ColorConstants.textPrimary,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: ColorConstants.textPrimary,
  );
  
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: ColorConstants.textPrimary,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ColorConstants.textPrimary,
  );
  
  static const TextStyle labelLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: ColorConstants.textPrimary,
  );
  
  static const TextStyle hintText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: ColorConstants.textHint,
  );
  
  // Button Styles
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: ColorConstants.primary,
    foregroundColor: ColorConstants.textOnPrimary,
    elevation: 0,
    padding: const EdgeInsets.symmetric(
      horizontal: SpacingConstants.xl,
      vertical: SpacingConstants.buttonPadding,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
    ),
    minimumSize: const Size(
      SpacingConstants.buttonMinWidth,
      SpacingConstants.buttonHeight,
    ),
  );
  
  static final ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: ColorConstants.surface,
    foregroundColor: ColorConstants.textPrimary,
    elevation: 0,
    padding: const EdgeInsets.symmetric(
      horizontal: SpacingConstants.xl,
      vertical: SpacingConstants.buttonPadding,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
    ),
    minimumSize: const Size(
      SpacingConstants.buttonMinWidth,
      SpacingConstants.buttonHeight,
    ),
  );
  
  // Input Decoration
  static InputDecoration inputDecoration({
    required String hintText,
    String? errorText,
    Widget? suffixIcon,
    Widget? prefixIcon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: ColorConstants.surface,
      hintText: hintText,
      // hintStyle: hint,
      errorText: errorText,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: SpacingConstants.inputPadding,
        vertical: SpacingConstants.inputPadding,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        borderSide: const BorderSide(
          color: ColorConstants.primary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        borderSide: const BorderSide(
          color: ColorConstants.error,
          width: 2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        borderSide: const BorderSide(
          color: ColorConstants.error,
          width: 2,
        ),
      ),
    );
  }
  
  // Loading Indicator
  static const Widget loadingIndicator = SizedBox(
    height: 20,
    width: 20,
    child: CircularProgressIndicator(
      strokeWidth: 2,
      color: ColorConstants.textOnPrimary,
    ),
  );
  
  // Shadows
  static const List<BoxShadow> defaultShadow = [
    BoxShadow(
      color: ColorConstants.shadow,
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];
  
  // Container Decoration
  static BoxDecoration containerDecoration({
    Color? color,
    double? borderRadius,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      color: color ?? ColorConstants.surface,
      borderRadius: BorderRadius.circular(borderRadius ?? AppConstants.borderRadius),
      boxShadow: boxShadow,
    );
  }
}