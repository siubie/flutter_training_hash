import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_shop/register/datasource/register_datasource.dart';
import 'package:new_shop/register/request/register_request.dart';
import 'package:new_shop/register/response/register_response.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterDatasource datasource;

  RegisterBloc(this.datasource) : super(RegisterInitial()) {
    on<UserTapRegisterButtonEvent>((event, emit) async {
      emit(RegisterLoading());
      // await Future.delayed(const Duration(seconds: 2));
      final response = await datasource.registerUser(event.request);
      response.fold(
        (error) => emit(RegisterFailed()),
        (data) => emit(RegisterSuccess(data)),
      );
    });

    on<UserTapLoginButtonEvent>((event, emit) async {
      emit(RegisterLoading());
      await Future.delayed(const Duration(seconds: 2));
      emit(RegisterInitial());
    });
  }
}
