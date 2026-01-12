import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthChecking extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String token;
  final String? userName;

  const AuthAuthenticated(this.token, {this.userName});

  @override
  List<Object> get props => [token];
}

class AuthUnauthenticated extends AuthState {}

class AuthLoginError extends AuthState {
  final String message;

  const AuthLoginError(this.message);

  @override
  List<Object> get props => [message];
}

class AuthTokenExpired extends AuthState {
  final String message;

  const AuthTokenExpired(this.message);

  @override
  List<Object> get props => [message];
}

class AuthLoggedOut extends AuthState {}
