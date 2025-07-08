import 'package:chatapp/core/constants/app_constants.dart';
import 'package:chatapp/core/constants/color_constants.dart';
import 'package:chatapp/core/constants/spacing_constants.dart';
import 'package:chatapp/core/constants/style_constants.dart';
import 'package:flutter/material.dart';

/// A highly customizable button widget that follows the app's design system
/// 
/// This widget provides a consistent button experience across the app with
/// support for loading states, icons, and various styling options.
class CustomButton extends StatelessWidget {
  /// The text to display on the button
  final String text;
  
  /// Callback function when button is pressed
  final VoidCallback? onPressed;
  
  /// Whether to show loading indicator
  final bool isLoading;
  
  /// Whether the button is enabled
  final bool enabled;
  
  /// Custom background color (overrides theme)
  final Color? backgroundColor;
  
  /// Custom text color (overrides theme)
  final Color? textColor;
  
  /// Custom button width
  final double? width;
  
  /// Custom button height
  final double? height;
  
  /// Custom padding
  final EdgeInsetsGeometry? padding;
  
  /// Custom border radius
  final BorderRadius? borderRadius;
  
  /// Optional icon to display before text
  final Widget? icon;
  
  /// Custom button style (overrides all other styling)
  final ButtonStyle? customStyle;
  
  /// Button variant type
  final ButtonVariant variant;
  
  /// Button size preset
  final ButtonSize size;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.icon,
    this.customStyle,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
  });

  /// Factory constructor for primary button
  const CustomButton.primary({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool enabled = true,
    Widget? icon,
    ButtonSize size = ButtonSize.medium,
    double? width,
  }) : this(
          key: key,
          text: text,
          onPressed: onPressed,
          isLoading: isLoading,
          enabled: enabled,
          icon: icon,
          size: size,
          width: width,
          variant: ButtonVariant.primary,
        );

  /// Factory constructor for secondary button
  const CustomButton.secondary({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool enabled = true,
    Widget? icon,
    ButtonSize size = ButtonSize.medium,
    double? width,
  }) : this(
          key: key,
          text: text,
          onPressed: onPressed,
          isLoading: isLoading,
          enabled: enabled,
          icon: icon,
          size: size,
          width: width,
          variant: ButtonVariant.secondary,
        );

  /// Factory constructor for outlined button
  const CustomButton.outlined({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool enabled = true,
    Widget? icon,
    ButtonSize size = ButtonSize.medium,
    double? width,
  }) : this(
          key: key,
          text: text,
          onPressed: onPressed,
          isLoading: isLoading,
          enabled: enabled,
          icon: icon,
          size: size,
          width: width,
          variant: ButtonVariant.outlined,
        );

  /// Factory constructor for text button
  const CustomButton.text({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool enabled = true,
    Widget? icon,
    ButtonSize size = ButtonSize.medium,
    double? width,
  }) : this(
          key: key,
          text: text,
          onPressed: onPressed,
          isLoading: isLoading,
          enabled: enabled,
          icon: icon,
          size: size,
          width: width,
          variant: ButtonVariant.text,
        );

  @override
  Widget build(BuildContext context) {
    final isDisabled = !enabled || isLoading || onPressed == null;
    
    return SizedBox(
      width: width ?? double.infinity,
      height: _getButtonHeight(),
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: customStyle ?? _getButtonStyle(),
        child: _buildButtonContent(),
      ),
    );
  }

  /// Builds the button content with loading state handling
  Widget _buildButtonContent() {
    if (isLoading) {
      return _buildLoadingIndicator();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          icon!,
          const SizedBox(width: SpacingConstants.sm),
        ],
        Flexible(
          child: Text(
            text,
            style: _getTextStyle(),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  /// Builds the loading indicator
  Widget _buildLoadingIndicator() {
    final loadingSize = _getLoadingSize();
    final loadingColor = _getLoadingColor();
    
    return SizedBox(
      height: loadingSize,
      width: loadingSize,
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(loadingColor),
      ),
    );
  }

  /// Gets the button style based on variant
  ButtonStyle _getButtonStyle() {
    switch (variant) {
      case ButtonVariant.primary:
        return _getPrimaryButtonStyle();
      case ButtonVariant.secondary:
        return _getSecondaryButtonStyle();
      case ButtonVariant.outlined:
        return _getOutlinedButtonStyle();
      case ButtonVariant.text:
        return _getTextButtonStyle();
    }
  }

  /// Gets primary button style
  ButtonStyle _getPrimaryButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? ColorConstants.primary,
      foregroundColor: textColor ?? ColorConstants.textOnPrimary,
      disabledBackgroundColor: ColorConstants.disabled.withValues(alpha: 0.3),
      disabledForegroundColor: ColorConstants.textHint,
      elevation: 0,
      shadowColor: ColorConstants.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(AppConstants.buttonBorderRadius),
      ),
      padding: padding ?? _getButtonPadding(),
      minimumSize: Size(_getMinWidth(), _getButtonHeight()),
      maximumSize: Size(double.infinity, _getButtonHeight()),
    );
  }

  /// Gets secondary button style
  ButtonStyle _getSecondaryButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? ColorConstants.surface,
      foregroundColor: textColor ?? ColorConstants.textPrimary,
      disabledBackgroundColor: ColorConstants.disabled.withValues( alpha: 0.3),
      disabledForegroundColor: ColorConstants.textHint,
      elevation: 0,
      shadowColor: ColorConstants.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(AppConstants.buttonBorderRadius),
      ),
      padding: padding ?? _getButtonPadding(),
      minimumSize: Size(_getMinWidth(), _getButtonHeight()),
      maximumSize: Size(double.infinity, _getButtonHeight()),
    );
  }

  /// Gets outlined button style
  ButtonStyle _getOutlinedButtonStyle() {
    return OutlinedButton.styleFrom(
      backgroundColor: backgroundColor ?? ColorConstants.transparent,
      foregroundColor: textColor ?? ColorConstants.primary,
      disabledBackgroundColor: ColorConstants.transparent,
      disabledForegroundColor: ColorConstants.textHint,
      elevation: 0,
      side: BorderSide(
        color: enabled ? ColorConstants.primary : ColorConstants.disabled,
        width: 1.5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(AppConstants.buttonBorderRadius),
      ),
      padding: padding ?? _getButtonPadding(),
      minimumSize: Size(_getMinWidth(), _getButtonHeight()),
      maximumSize: Size(double.infinity, _getButtonHeight()),
    );
  }

  /// Gets text button style
  ButtonStyle _getTextButtonStyle() {
    return TextButton.styleFrom(
      backgroundColor: backgroundColor ?? ColorConstants.transparent,
      foregroundColor: textColor ?? ColorConstants.primary,
      disabledBackgroundColor: ColorConstants.transparent,
      disabledForegroundColor: ColorConstants.textHint,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(AppConstants.buttonBorderRadius),
      ),
      padding: padding ?? _getButtonPadding(),
      minimumSize: Size(_getMinWidth(), _getButtonHeight()),
      maximumSize: Size(double.infinity, _getButtonHeight()),
    );
  }

  /// Gets button height based on size
  double _getButtonHeight() {
    if (height != null) return height!;
    
    switch (size) {
      case ButtonSize.small:
        return 40;
      case ButtonSize.medium:
        return SpacingConstants.buttonHeight;
      case ButtonSize.large:
        return 64;
    }
  }

  /// Gets button padding based on size
  EdgeInsetsGeometry _getButtonPadding() {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: SpacingConstants.md,
          vertical: SpacingConstants.sm,
        );
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: SpacingConstants.xl,
          vertical: SpacingConstants.buttonPadding,
        );
      case ButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: SpacingConstants.xxl,
          vertical: SpacingConstants.xl,
        );
    }
  }

  /// Gets minimum width based on size
  double _getMinWidth() {
    switch (size) {
      case ButtonSize.small:
        return 80;
      case ButtonSize.medium:
        return SpacingConstants.buttonMinWidth;
      case ButtonSize.large:
        return 160;
    }
  }

  /// Gets text style based on size
  TextStyle _getTextStyle() {
    switch (size) {
      case ButtonSize.small:
        return StyleConstants.bodyMedium.copyWith(
          fontWeight: FontWeight.w600,
        );
      case ButtonSize.medium:
        return StyleConstants.labelLarge.copyWith(
          fontWeight: FontWeight.w600,
        );
      case ButtonSize.large:
        return StyleConstants.titleMedium.copyWith(
          fontWeight: FontWeight.w600,
        );
    }
  }

  /// Gets loading indicator size
  double _getLoadingSize() {
    switch (size) {
      case ButtonSize.small:
        return 16.0;
      case ButtonSize.medium:
        return 20.0;
      case ButtonSize.large:
        return 24.0;
    }
  }

  /// Gets loading indicator color
  Color _getLoadingColor() {
    switch (variant) {
      case ButtonVariant.primary:
        return ColorConstants.textOnPrimary;
      case ButtonVariant.secondary:
        return ColorConstants.textPrimary;
      case ButtonVariant.outlined:
      case ButtonVariant.text:
        return ColorConstants.primary;
    }
  }
}

/// Button variant types
enum ButtonVariant {
  primary,
  secondary,
  outlined,
  text,
}

/// Button size presets
enum ButtonSize {
  small,
  medium,
  large,
}