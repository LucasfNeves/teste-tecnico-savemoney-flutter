import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_create_flutter/presentation/blocs/auth/auth_bloc.dart';
import 'package:teste_create_flutter/presentation/blocs/auth/auth_event.dart';
import 'package:teste_create_flutter/core/routes/app_routes.dart';
import 'package:teste_create_flutter/shared/layouts/main_layout.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainLayout(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Users List Screen'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutRequested());
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.login,
                  (route) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
