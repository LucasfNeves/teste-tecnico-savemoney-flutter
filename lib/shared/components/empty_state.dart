// /home/lneves/projects/savemoney_flutter/lib/shared/components/state_display.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StateDisplay extends StatelessWidget {
  final String? svgPath;
  final IconData? icon;
  final String title;
  final String? subtitle;
  final Color? iconColor;
  final double? imageSize;
  final Widget? action;

  const StateDisplay({
    super.key,
    this.svgPath,
    this.icon,
    required this.title,
    this.subtitle,
    this.iconColor,
    this.imageSize,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            if (svgPath != null || icon != null) const SizedBox(height: 24),
            if (svgPath != null)
              SvgPicture.asset(
                svgPath!,
                height: imageSize ?? 120,
                colorFilter: iconColor != null
                    ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                    : null,
              )
            else if (icon != null)
              Icon(
                icon!,
                size: imageSize ?? 64,
                color: iconColor ??
                    Theme.of(context).colorScheme.primary.withOpacity(0.5),
              ),
            if (action != null) ...[
              const SizedBox(height: 24),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
