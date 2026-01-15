import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserRequested extends UserEvent {
  const GetUserRequested();
}

class UpdateUserProfileRequested extends UserEvent {
  final Map<String, dynamic> data;

  const UpdateUserProfileRequested(this.data);

  @override
  List<Object> get props => [data];
}

class DeleteUserAccountRequested extends UserEvent {
  const DeleteUserAccountRequested();
}
