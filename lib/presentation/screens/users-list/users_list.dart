import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/owner_user_card.dart';
import 'package:teste_create_flutter/shared/components/custom_divider.dart';
import 'package:teste_create_flutter/shared/layouts/main_layout.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_bloc.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_event.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_state.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(const GetUserRequested()),
      child: MainLayout(
        child: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Usuários Cadastrados',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 12),
              Text('1 usuário', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              const CustomDivider(),
              const SizedBox(height: 16),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is UserSuccess) {
                    return OwnerUserCard(user: state.user);
                  }

                  if (state is UserError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 16),
              const CustomDivider(),
            ],
          ),
        ),
      ),
    );
  }
}
