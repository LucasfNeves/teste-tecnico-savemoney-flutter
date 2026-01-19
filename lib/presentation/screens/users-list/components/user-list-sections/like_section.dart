import 'package:flutter/material.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/user-list-sections/section_title.dart';
import 'package:teste_create_flutter/shared/components/like_card.dart';

class LikeSection extends StatelessWidget {
  const LikeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Avalie nossa Plataforma'),
        const SizedBox(height: 12),
        const LikeCard(),
      ],
    );
  }
}
