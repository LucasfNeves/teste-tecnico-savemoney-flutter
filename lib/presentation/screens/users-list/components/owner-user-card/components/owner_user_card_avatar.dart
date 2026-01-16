import 'package:flutter/material.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';

class OwnerUserCardAvatar extends StatelessWidget {
  final String initial;
  final double radius;

  const OwnerUserCardAvatar({
    super.key,
    required this.initial,
    this.radius = 48,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppTheme.primaryPurple,
      child: Text(
        initial,
        style: TextStyle(
          color: Colors.white,
          fontSize: radius * 0.83,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
