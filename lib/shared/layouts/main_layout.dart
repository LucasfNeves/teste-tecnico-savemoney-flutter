import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';
import 'package:teste_create_flutter/presentation/blocs/counter/counter_bloc.dart';
import 'package:teste_create_flutter/shared/components/header.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Header(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.globalPadding),
                width: double.infinity,
                color: AppTheme.backgroundLight,
                child: child,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {context.read<CounterBloc>().increment()},
        tooltip: 'Like',
        backgroundColor: AppTheme.primaryPurple,
        child: Icon(Icons.thumb_up, color: AppTheme.white),
      ),
    );
  }
}
