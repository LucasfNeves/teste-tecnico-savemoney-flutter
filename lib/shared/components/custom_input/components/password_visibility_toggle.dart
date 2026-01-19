import 'package:flutter/material.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';

class PasswordVisibilityToggle extends StatelessWidget {
  final bool isObscured;
  final VoidCallback onToggle;
  final Color? iconColor;

  const PasswordVisibilityToggle({
    super.key,
    required this.isObscured,
    required this.onToggle,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Icon(
        isObscured ? Icons.visibility : Icons.visibility_off,
        color: iconColor ?? AppTheme.textSecondary,
      ),
    );
  }
}
