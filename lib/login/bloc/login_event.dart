part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class UserTapLoginButtonEvent extends LoginEvent {
  final LoginRequest request;

  const UserTapLoginButtonEvent({required this.request});

  @override
  List<Object> get props => [request];
}
