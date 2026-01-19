import 'package:flutter/material.dart';

class PhoneInputConfig {
  final double areaCodeWidth;
  final double spacing;
  final double minHeight;
  final double borderRadius;
  final double borderWidth;
  final String areaCodeHint;
  final String phoneHint;
  final IconData? phoneIcon;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? iconColor;

  const PhoneInputConfig({
    this.areaCodeWidth = 80,
    this.spacing = 12,
    this.minHeight = 56,
    this.borderRadius = 8,
    this.borderWidth = 1,
    this.areaCodeHint = '11',
    this.phoneHint = '9 9999-9999',
    this.phoneIcon = Icons.phone,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.iconColor,
  });

  static const PhoneInputConfig defaultConfig = PhoneInputConfig();

  PhoneInputConfig copyWith({
    double? areaCodeWidth,
    double? spacing,
    double? minHeight,
    double? borderRadius,
    double? borderWidth,
    String? areaCodeHint,
    String? phoneHint,
    IconData? phoneIcon,
    Color? enabledBorderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    Color? iconColor,
  }) {
    return PhoneInputConfig(
      areaCodeWidth: areaCodeWidth ?? this.areaCodeWidth,
      spacing: spacing ?? this.spacing,
      minHeight: minHeight ?? this.minHeight,
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      areaCodeHint: areaCodeHint ?? this.areaCodeHint,
      phoneHint: phoneHint ?? this.phoneHint,
      phoneIcon: phoneIcon ?? this.phoneIcon,
      enabledBorderColor: enabledBorderColor ?? this.enabledBorderColor,
      focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      iconColor: iconColor ?? this.iconColor,
    );
  }
}
