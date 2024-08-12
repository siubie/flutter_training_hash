part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

final class UserTapRegisterButtonEvent extends RegisterEvent {
  final RegisterRequest request;

  const UserTapRegisterButtonEvent({required this.request});

  @override
  List<Object> get props => [request];
}
