import 'package:equatable/equatable.dart';
import 'package:teste_create_flutter/domain/models/user_model.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

// current users states
class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final User user;

  const UserSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object> get props => [message];
}

// Estados para atualizar perfil
class UserUpdateLoading extends UserState {}

class UserUpdateSuccess extends UserState {
  final User updatedUser;
  const UserUpdateSuccess(this.updatedUser);

  @override
  List<Object> get props => [updatedUser];
}

class UserUpdateError extends UserState {
  final String message;
  const UserUpdateError(this.message);

  @override
  List<Object> get props => [message];
}

// Estados para deletar conta
class UserDeleteLoading extends UserState {}

class UserDeleteSuccess extends UserState {}

class UserDeleteError extends UserState {
  final String message;
  const UserDeleteError(this.message);

  @override
  List<Object> get props => [message];
}
