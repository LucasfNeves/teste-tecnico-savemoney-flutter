import 'package:flutter/material.dart';
import 'package:teste_create_flutter/shared/components/simple-user-crad-skelleton.dart';

class UsersListSkeleton extends StatelessWidget {
  const UsersListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        4,
        (index) => const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: SimpleUserCardSkeleton(),
        ),
      ),
    );
  }
}
