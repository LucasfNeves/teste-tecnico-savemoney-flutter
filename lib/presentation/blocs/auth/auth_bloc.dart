import 'package:bloc/bloc.dart';
import 'package:teste_create_flutter/domain/repositories/auth_service.dart';
import 'package:teste_create_flutter/core/services/auth-service/auth_service_remote.dart';
import 'package:teste_create_flutter/domain/models/token_storage.dart';
import 'package:teste_create_flutter/presentation/blocs/auth/auth_event.dart';
import 'package:teste_create_flutter/presentation/blocs/auth/auth_state.dart';
import 'package:teste_create_flutter/shared/utils/error_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService = AuthServiceRemote();

  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthCheckRequested>(_onCheckRequested);
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final response = await _authService.login(event.email, event.password);

      final token = response.data['accessToken'];
      await TokenStorage.saveToken(token);
      emit(const AuthAuthenticated('Login realizado com sucesso'));
    } catch (e) {
      emit(AuthLoginError(ErrorHandler.getErrorMessage(e)));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await TokenStorage.clearToken();
    emit(AuthUnauthenticated());
  }

  Future<void> _onCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    await TokenStorage.loadToken();
    if (TokenStorage.hasToken) {
      emit(const AuthAuthenticated('Token válido'));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
