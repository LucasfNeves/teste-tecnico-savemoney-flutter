// lib/shared/components/like_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_create_flutter/core/routes/app_routes.dart';
import 'package:teste_create_flutter/presentation/blocs/counter/counter_bloc.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../presentation/blocs/counter/counter_state.dart';

class LikeCard extends StatefulWidget {
  final bool isFullScreen;

  const LikeCard({
    super.key,
    this.isFullScreen = false,
  });

  @override
  State<LikeCard> createState() => _LikeCardState();
}

class _LikeCardState extends State<LikeCard> {
  void _handleCardTap() {
    if (!widget.isFullScreen) {
      Navigator.of(context).pushNamed(AppRoutes.like);
    }
  }

  void _handleStarTap(int index) {
    final counterBloc = context.read<CounterBloc>();
    for (int i = 0; i <= index; i++) {
      counterBloc.increment();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleCardTap,
      child: Card(
        color: AppTheme.cardBackground,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          side: BorderSide(
            color: AppTheme.cardBorderColor,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.globalPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: widget.isFullScreen
                        ? () => _handleStarTap(index)
                        : null,
                    child: Icon(
                      Icons.star,
                      size: widget.isFullScreen ? 48 : 32,
                      color: AppTheme.primaryPurple,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 14),
              Text(
                'Quantas curtidas este app merece?',
                style: TextStyle(
                  fontSize: widget.isFullScreen ? 18 : 16,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              BlocBuilder<CounterBloc, CounterState>(
                builder: (context, state) {
                  final counter = state is CounterValue ? state.counter : 0;
                  return Text(
                    '$counter',
                    style: TextStyle(
                      fontSize: widget.isFullScreen ? 64 : 40,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.primaryPurple,
                    ),
                  );
                },
              ),
              const SizedBox(height: 4),
              Text(
                'Curtidas',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
