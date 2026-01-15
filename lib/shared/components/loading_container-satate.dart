// /home/lneves/projects/savemoney_flutter/lib/shared/components/loading_state.dart
import 'package:flutter/material.dart';

class LoadingContainerState extends StatelessWidget {
  final double? heightFactor;
  final String? message;

  const LoadingContainerState({
    super.key,
    this.heightFactor = 0.5,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * (heightFactor ?? 0.5),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(
                message!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
