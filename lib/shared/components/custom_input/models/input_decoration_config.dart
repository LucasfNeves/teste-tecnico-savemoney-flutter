import 'package:flutter/material.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';

class InputDecorationConfig {
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsets? contentPadding;
  final BoxConstraints? constraints;

  const InputDecorationConfig({
    this.labelText,
    this.hintText,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.borderWidth = 1.0,
    this.borderRadius = 8.0,
    this.contentPadding,
    this.constraints,
  });

  InputDecoration toInputDecoration() {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      helperText: helperText,
      labelStyle: TextStyle(color: AppTheme.textLabel),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon != null
          ? Padding(
              padding: const EdgeInsets.only(right: 12),
              child: suffixIcon,
            )
          : null,
      contentPadding: contentPadding,
      constraints: constraints ?? const BoxConstraints(minHeight: 56),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: borderColor ?? AppTheme.borderColor,
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: borderColor ?? AppTheme.borderColor,
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: focusedBorderColor ?? AppTheme.accentPurple,
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: errorBorderColor ?? AppTheme.errorColor,
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }

  InputDecorationConfig copyWith({
    String? labelText,
    String? hintText,
    String? helperText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    double? borderWidth,
    double? borderRadius,
    EdgeInsets? contentPadding,
    BoxConstraints? constraints,
  }) {
    return InputDecorationConfig(
      labelText: labelText ?? this.labelText,
      hintText: hintText ?? this.hintText,
      helperText: helperText ?? this.helperText,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      suffixIcon: suffixIcon ?? this.suffixIcon,
      borderColor: borderColor ?? this.borderColor,
      focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      contentPadding: contentPadding ?? this.contentPadding,
      constraints: constraints ?? this.constraints,
    );
  }
}
