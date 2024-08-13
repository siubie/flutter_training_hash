import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_shop/register/datasource/register_datasource.dart';
import 'package:new_shop/register/request/register_request.dart';
import 'package:new_shop/register/response/register_failed_response.dart';
import 'package:new_shop/register/response/register_success_response.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterDatasource datasource;

  RegisterBloc(this.datasource) : super(RegisterInitial()) {
    on<UserTapRegisterButtonEvent>((event, emit) async {
      emit(RegisterLoading());
      // await Future.delayed(const Duration(seconds: 2));
      final (RegisterFailedResponse? failed, RegisterSuccessResponse? success) =
          await datasource.registerUser(event.request);
      if (success != null) {
        emit(RegisterSuccess(success));
      } else {
        emit(RegisterFailed(response: failed!));
      }
    });
  }
}
