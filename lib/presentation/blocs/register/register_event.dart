import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterRequested extends RegisterEvent {
  final String name;
  final String email;
  final String password;
  final List<Map<String, dynamic>> telephones;

  const RegisterRequested({
    required this.name,
    required this.email,
    required this.password,
    required this.telephones,
  });

  @override
  List<Object> get props => [name, email, password, telephones];
}
