import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/owner-user-card/owner_user_card.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/owner-user-card/components/user_card_skeleton.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/owner-user-card/components/user_card_error.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/simple_user_card.dart';
import 'package:teste_create_flutter/shared/components/custom_divider.dart';
import 'package:teste_create_flutter/shared/components/empty_state.dart';
import 'package:teste_create_flutter/shared/components/simple-user-crad-skelleton.dart';
import 'package:teste_create_flutter/shared/layouts/main_layout.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_bloc.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_event.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_state.dart';
import 'package:teste_create_flutter/presentation/blocs/user-list/user_list_bloc.dart';
import 'package:teste_create_flutter/presentation/blocs/user-list/user_list_event.dart';
import 'package:teste_create_flutter/presentation/blocs/user-list/user_list_state.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final UserBloc _userBloc = UserBloc();
  final UsersListBloc _usersListBloc = UsersListBloc();

  @override
  void initState() {
    super.initState();

    _userBloc.add(const GetUserRequested());
    _usersListBloc.add(GetUsersListRequested());
  }

  @override
  void dispose() {
    _userBloc.close();
    _usersListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: _userBloc,
        child: MainLayout(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Usuários Cadastrados',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 12),
                StreamBuilder<UsersListState>(
                  stream: _usersListBloc.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data is UsersListLoaded) {
                      final state = snapshot.data as UsersListLoaded;
                      return Text('${state.users.length + 1} usuários',
                          style: Theme.of(context).textTheme.bodyMedium);
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 16),
                const CustomDivider(),
                const SizedBox(height: 16),
                StreamBuilder<UserState>(
                  stream: _userBloc.stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const UserCardSkeleton();
                    }

                    final state = snapshot.data;

                    if (state is UserLoading) {
                      return const UserCardSkeleton();
                    }

                    if (state is UserSuccess) {
                      return OwnerUserCard(user: state.user);
                    }

                    if (state is UserError) {
                      return UserCardError(
                        onRetry: () => _userBloc.add(const GetUserRequested()),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 16),
                const CustomDivider(),
                const SizedBox(height: 16),
                StreamBuilder<UsersListState>(
                  stream: _usersListBloc.stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData ||
                        (snapshot.data is UsersListLoaded &&
                            (snapshot.data as UsersListLoaded).users.isEmpty)) {
                      return const StateDisplay(
                        title: 'Não há outros usuários cadastrados',
                        svgPath: 'lib/assets/emptity-state.svg',
                        imageSize: 160,
                      );
                    }

                    final state = snapshot.data!;

                    if (state is UsersListLoading || !snapshot.hasData) {
                      return Column(
                        children: List.generate(
                          4,
                          (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: SimpleUserCardSkeleton(),
                          ),
                        ),
                      );
                    }

                    if (state is UsersListError) {
                      return StateDisplay(
                        title: 'Erro ao carregar usuários',
                        subtitle: state.message,
                        icon: Icons.error_outline,
                        iconColor: AppTheme.primaryPurple,
                        action: ElevatedButton(
                          onPressed: () =>
                              _usersListBloc.add(GetUsersListRequested()),
                          child: const Text('Tentar novamente'),
                        ),
                      );
                    }

                    if (state is UsersListLoaded) {
                      return Column(
                        children: state.users
                            .map((user) => Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: SimpleUserCard(
                                    name: user.name,
                                    email: user.email,
                                    createdAt: user.createdAt.toString(),
                                  ),
                                ))
                            .toList(),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
