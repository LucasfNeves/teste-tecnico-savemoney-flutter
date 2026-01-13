import 'package:flutter/material.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';

class SecundaryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const SecundaryButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: AppTheme.primaryPurple),
      label: Text(
        label,
        style: TextStyle(color: AppTheme.primaryPurple),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppTheme.primaryPurple),
        minimumSize: const Size(double.infinity, 48),
      ),
    );
  }
}
