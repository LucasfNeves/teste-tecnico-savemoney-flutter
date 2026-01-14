import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/owner-user-card/owner_user_card.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/owner-user-card/components/user_card_skeleton.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/owner-user-card/components/user_card_error.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/simple_user_card.dart';
import 'package:teste_create_flutter/shared/components/custom_divider.dart';
import 'package:teste_create_flutter/shared/layouts/main_layout.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_bloc.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_event.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_state.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final UserBloc _userBloc = UserBloc();

  final List<Map<String, String>> _mockUsers = [
    {
      'name': 'Lucas F. S.',
      'email': 'luc***@g*****.com**',
      'createdAt': '2026-01-13'
    },
    {
      'name': 'Maria Silva',
      'email': 'mar***@g*****.com**',
      'createdAt': '2026-01-12'
    },
    {
      'name': 'João Santos',
      'email': 'joa***@g*****.com**',
      'createdAt': '2026-01-11'
    },
    {
      'name': 'Ana Costa',
      'email': 'ana***@g*****.com**',
      'createdAt': '2026-01-10'
    },
  ];

  @override
  void initState() {
    super.initState();
    _userBloc.add(const GetUserRequested());
  }

  @override
  void dispose() {
    _userBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      bloc: _userBloc,
      listener: (context, state) {
        if (state is UserError) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(message: state.message),
          );
        }
      },
      child: BlocProvider.value(
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
                Text('${_mockUsers.length + 1} usuários',
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 16),
                const CustomDivider(),
                const SizedBox(height: 16),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
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
                ..._mockUsers.map((user) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SimpleUserCard(
                        name: user['name']!,
                        email: user['email']!,
                        createdAt: user['createdAt']!,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
