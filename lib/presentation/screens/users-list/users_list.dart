import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/user-list-sections/like_section.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/user-list-sections/myprofile_section.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/user-list-sections/users-list-section/users_list_section.dart';
import 'package:teste_create_flutter/shared/components/custom_divider.dart';
import 'package:teste_create_flutter/shared/layouts/main_layout.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_bloc.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_event.dart';
import 'package:teste_create_flutter/presentation/blocs/user-list/user_list_bloc.dart';
import 'package:teste_create_flutter/presentation/blocs/user-list/user_list_event.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  late final UserBloc _userBloc;
  late final UsersListBloc _usersListBloc;

  @override
  void initState() {
    super.initState();
    _userBloc = UserBloc();
    _usersListBloc = UsersListBloc();

    _loadInitialData();
  }

  void _loadInitialData() {
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
          padding: const EdgeInsets.only(top: 32, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LikeSection(),
              const SizedBox(height: 32),
              const CustomDivider(),
              const SizedBox(height: 32),
              MyProfileSection(userBloc: _userBloc),
              const SizedBox(height: 32),
              const CustomDivider(),
              const SizedBox(height: 32),
              UsersListSection(
                usersListBloc: _usersListBloc,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
