import 'package:flutter/material.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';
import 'package:teste_create_flutter/shared/utils/strings_utils.dart';

class SmalTextWithIcon extends StatelessWidget {
  final IconData icon;
  final String text;

  const SmalTextWithIcon({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppTheme.textSecondary,
        ),
        const SizedBox(width: 8),
        Text(
          text.truncateWithEllipsis(20),
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ],
    );
  }
}
