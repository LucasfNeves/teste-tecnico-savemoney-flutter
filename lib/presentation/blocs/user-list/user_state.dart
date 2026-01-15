import 'package:teste_create_flutter/domain/models/users_list_model.dart';

abstract class UsersListState {}

class UsersListInitial extends UsersListState {}

class UsersListLoading extends UsersListState {}

class UsersListLoaded extends UsersListState {
  final List<UserList> users;
  UsersListLoaded(this.users);
}

class UsersListError extends UsersListState {
  final String message;
  UsersListError(this.message);
}
