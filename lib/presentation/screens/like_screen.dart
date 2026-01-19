// lib/presentation/screens/like_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';
import 'package:teste_create_flutter/presentation/blocs/counter/counter_bloc.dart';
import 'package:teste_create_flutter/shared/components/like_card.dart';
import 'package:teste_create_flutter/shared/components/secundary_button.dart';
import 'package:teste_create_flutter/shared/layouts/main_layout.dart';

class LikeScreen extends StatelessWidget {
  const LikeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const LikeCard(
                  isFullScreen: true,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.read<CounterBloc>().reset();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Resetar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.cardBorderColor,
                      foregroundColor: AppTheme.textPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SecundaryButton(
                    icon: Icons.home,
                    label: 'Voltar para a Home',
                    onPressed: () =>
                        Navigator.pushNamed(context, '/users-list')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
