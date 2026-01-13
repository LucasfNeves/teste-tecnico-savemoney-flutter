import 'package:flutter/material.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';

class CustomDivider extends StatelessWidget {
  final double? height;
  final Color? color;
  final double? thickness;

  const CustomDivider({
    super.key,
    this.height,
    this.color,
    this.thickness,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height ?? 2,
      color: color ?? AppTheme.dividerColor,
      thickness: thickness ?? 1,
    );
  }
}
