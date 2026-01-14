import 'package:flutter/material.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';

class UserCardError extends StatelessWidget {
  final VoidCallback onRetry;

  const UserCardError({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.accentPurple,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.primaryPurple),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 40,
            color: AppTheme.primaryPurple,
          ),
          const SizedBox(height: 12),
          Text(
            'Ocorreu um erro',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tentar novamente',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          IconButton(
            onPressed: onRetry,
            icon: Icon(
              Icons.refresh,
              size: 32,
              color: AppTheme.primaryPurple,
            ),
          ),
        ],
      ),
    );
  }
}
