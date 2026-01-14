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
    on<GetUserRequested>(_onGetUserRequested);
  }

  Future<void> _onGetUserRequested(
    GetUserRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());

    try {
      final token = TokenStorage.getToken();

      if (token == null) {
        emit(UserError('Token não encontrado. Faça login novamente.'));
        return;
      }

      final response = await _userService.getUserById();

      if (response.statusCode == 200) {
        final user = User.fromJson(response.data);
        emit(UserSuccess(user));
      } else {
        emit(UserError(
            'Erro ${response.statusCode}: ${response.statusMessage}'));
      }
    } catch (e) {
      final errorMessage = ErrorHandler.getErrorMessage(e);
      emit(UserError(errorMessage));
    }
  }
}
