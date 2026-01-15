import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_create_flutter/core/services/user-service/user_service_remote.dart';
import 'package:teste_create_flutter/domain/models/users_list_model.dart';
import 'package:teste_create_flutter/domain/repositories/user_service.dart';
import 'package:teste_create_flutter/presentation/blocs/user-list/user_list_event.dart';
import 'package:teste_create_flutter/presentation/blocs/user-list/user_list_state.dart';
import 'package:teste_create_flutter/shared/utils/error_handler.dart';

class UsersListBloc extends Bloc<UsersListEvent, UsersListState> {
  final UserService _userService = UserServiceRemote();

  UsersListBloc() : super(UsersListInitial()) {
    on<GetUsersListRequested>(_onGetUsersListRequested);
  }

  Future<void> _onGetUsersListRequested(
    GetUsersListRequested event,
    Emitter<UsersListState> emit,
  ) async {
    emit(UsersListLoading());

    try {
      final response = await _userService.getUsersExcludeCurrentUser();

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final users = data.map((json) => UserList.fromJson(json)).toList();
        emit(UsersListLoaded(users));
      }
    } catch (e) {
      final errorMessage = ErrorHandler.getErrorMessage(e);

      emit(UsersListError(errorMessage));
    }
  }
}
