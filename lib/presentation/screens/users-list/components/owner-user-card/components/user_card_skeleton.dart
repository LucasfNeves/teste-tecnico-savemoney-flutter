import 'package:flutter/material.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';

class UserCardSkeleton extends StatefulWidget {
  const UserCardSkeleton({super.key});

  @override
  State<UserCardSkeleton> createState() => _UserCardSkeletonState();
}

class _UserCardSkeletonState extends State<UserCardSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Container(
            width: double.infinity,
            height: 124,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.skeletonBackground,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 1.0,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppTheme.skeletonBorder,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppTheme.skeletonBorder,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppTheme.skeletonBorder,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
