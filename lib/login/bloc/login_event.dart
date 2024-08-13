part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class UserTapLoginButtonEvent extends LoginEvent {}

final class UserSuccessfullyRegisteredEvent extends LoginEvent {
  final String message;

  const UserSuccessfullyRegisteredEvent({required this.message});

  @override
  List<Object> get props => [message];
}
