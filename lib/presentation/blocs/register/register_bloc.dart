import 'package:bloc/bloc.dart';
import 'package:teste_create_flutter/domain/repositories/register_service.dart';
import 'package:teste_create_flutter/core/services/register/register_service_remote.dart';
import 'package:teste_create_flutter/presentation/blocs/register/register_event.dart';
import 'package:teste_create_flutter/presentation/blocs/register/register_state.dart';
import 'package:teste_create_flutter/shared/utils/error_handler.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterService _registerService = RegisterServiceRemote();

  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterRequested>(_onRegisterRequested);
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());

    try {
      final response = await _registerService.register(
        event.name,
        event.email,
        event.password,
        event.telephones,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(RegisterSuccess());
      } else {
        emit(RegisterError('Erro ao registrar usuário'));
      }
    } catch (e) {
      emit(RegisterError(ErrorHandler.getErrorMessage(e)));
    }
  }
}
