part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final RegisterResponse response;

  const RegisterSuccess(this.response);

  @override
  List<Object> get props => [response];
}

final class RegisterFailed extends RegisterState {
  final RegisterFailedResponse response;

  const RegisterFailed({required this.response});

  @override
  List<Object> get props => [response];
}
