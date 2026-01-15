import 'package:bloc/bloc.dart';
import 'package:teste_create_flutter/domain/repositories/user_service.dart';
import 'package:teste_create_flutter/core/services/user-service/user_service_remote.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_event.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_state.dart';
import 'package:teste_create_flutter/shared/utils/error_handler.dart';
import 'package:teste_create_flutter/domain/models/user_model.dart';
import 'package:teste_create_flutter/domain/models/token_storage.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService _userService = UserServiceRemote();

  UserBloc() : super(UserInitial()) {
    on<GetUserRequested>(_onGetUserRequested);
    on<UpdateUserProfileRequested>(_onUpdateUserProfileRequested);
    on<DeleteUserAccountRequested>(_onDeleteUserAccountRequested);
  }

  Future<void> _onGetUserRequested(
    GetUserRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());

    try {
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

  Future<void> _onUpdateUserProfileRequested(
    UpdateUserProfileRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserUpdateLoading());

    try {
      final response = await _userService.updateUserProfile(event.data);

      if (response.statusCode == 200) {
        final updatedUser = User.fromJson(response.data);
        emit(UserUpdateSuccess(updatedUser));
      }
    } catch (e) {
      final errorMessage = ErrorHandler.getErrorMessage(e);
      emit(UserUpdateError(errorMessage));
    }
  }

  Future<void> _onDeleteUserAccountRequested(
    DeleteUserAccountRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserDeleteLoading());

    try {
      final response = await _userService.deleteUserAccount();

      if (response.statusCode == 200 || response.statusCode == 204) {
        await TokenStorage.clearToken();
        emit(UserDeleteSuccess());
      }
    } catch (e) {
      final errorMessage = ErrorHandler.getErrorMessage(e);
      emit(UserDeleteError(errorMessage));
    }
  }
}
