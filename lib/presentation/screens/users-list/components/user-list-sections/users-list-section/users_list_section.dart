import 'package:flutter/material.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';
import 'package:teste_create_flutter/presentation/blocs/user-list/user_list_bloc.dart';
import 'package:teste_create_flutter/presentation/blocs/user-list/user_list_event.dart';
import 'package:teste_create_flutter/presentation/blocs/user-list/user_list_state.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/simple_user_card.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/user-list-sections/section_title.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/user-list-sections/users-list-section/components/users_list_skeleton.dart';
import 'package:teste_create_flutter/shared/components/animate_on_visibility.dart';
import 'package:teste_create_flutter/shared/components/empty_state.dart';

class UsersListSection extends StatelessWidget {
  const UsersListSection({super.key, required this.usersListBloc});

  final UsersListBloc usersListBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: 'Outros Usuários'),
        const SizedBox(height: 4),
        StreamBuilder<UsersListState>(
          stream: usersListBloc.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data is UsersListLoaded) {
              final state = snapshot.data as UsersListLoaded;
              return Text(
                '${state.users.length + 1} usuários no total',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        const SizedBox(height: 16),
        StreamBuilder<UsersListState>(
          stream: usersListBloc.stream,
          builder: (context, snapshot) {
            final state = snapshot.data;

            if (state == null || state is UsersListLoading) {
              return const UsersListSkeleton();
            }

            if (state is UsersListLoaded) {
              if (state.users.isEmpty) {
                return const StateDisplay(
                  title: 'Não há outros usuários cadastrados',
                  svgPath: 'lib/assets/emptity-state.svg',
                  imageSize: 160,
                );
              }
              return Column(
                children: state.users
                    .map(
                      (user) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: AnimateOnVisibility(
                          child: SimpleUserCard(
                            name: user.name,
                            email: user.email,
                            createdAt: user.createdAt.toString(),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            }

            if (state is UsersListError) {
              return StateDisplay(
                title: 'Erro ao carregar usuários',
                subtitle: 'Não foi possível carregar a lista de usuários.',
                icon: Icons.error_outline,
                iconColor: AppTheme.primaryPurple,
                action: ElevatedButton(
                  onPressed: () => usersListBloc.add(GetUsersListRequested()),
                  child: const Text('Tentar novamente'),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
