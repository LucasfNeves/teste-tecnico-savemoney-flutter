import 'package:bloc/bloc.dart';
import 'package:teste_create_flutter/domain/models/token_storage.dart';
import 'package:teste_create_flutter/domain/repositories/user_service.dart';
import 'package:teste_create_flutter/core/services/user-service/user_service_remote.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_event.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_state.dart';
import 'package:teste_create_flutter/shared/utils/error_handler.dart';

import '../../../domain/models/user_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService _userService = UserServiceRemote();

  UserBloc() : super(UserInitial()) {
    print('UserBloc criado!');
    on<GetUserRequested>(_onGetUserRequested);
    print('Handler registrado para GetUserRequested');
  }

  Future<void> _onGetUserRequested(
    GetUserRequested event,
    Emitter<UserState> emit,
  ) async {
    print('_onGetUserRequested CHAMADO!');
    emit(UserLoading());

    try {
      final token = TokenStorage.getToken();
      print('Token encontrado: ${token != null ? "SIM" : "NÃO"}');

      if (token == null) {
        emit(UserError('Token não encontrado. Faça login novamente.'));
        return;
      }

      print('Fazendo requisição para /user...');
      final response = await _userService.getUserById();

      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final user = User.fromJson(response.data);
        print('User criado com sucesso: ${user.email}');
        emit(UserSuccess(user));
      } else {
        print(
            'Erro na resposta: ${response.statusCode} - ${response.statusMessage}');
        emit(UserError(
            'Erro ${response.statusCode}: ${response.statusMessage}'));
      }
    } catch (e) {
      print('Exception capturada: $e');
      final errorMessage = ErrorHandler.getErrorMessage(e);
      print('Mensagem de erro tratada: $errorMessage');
      emit(UserError(errorMessage));
    }
  }
}
