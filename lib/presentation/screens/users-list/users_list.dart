import 'package:flutter/material.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/owner_user_card.dart';
import 'package:teste_create_flutter/shared/components/custom_divider.dart';
import 'package:teste_create_flutter/shared/layouts/main_layout.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
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
            Text('5 usuários', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),
            const CustomDivider(),
            const SizedBox(height: 16),
            const OwnerUserCard(),
            const SizedBox(height: 16),
            const CustomDivider(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
