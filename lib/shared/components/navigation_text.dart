import 'package:flutter/material.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';

class NavigationText extends StatelessWidget {
  final String normalText;
  final String highlightText;
  final VoidCallback onTap;

  const NavigationText({
    super.key,
    required this.normalText,
    required this.highlightText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          text: normalText,
          style: TextStyle(color: AppTheme.textSecondary, fontSize: 16),
          children: [
            TextSpan(
              text: ' $highlightText',
              style: TextStyle(
                color: AppTheme.primaryPurple,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
