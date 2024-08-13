import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_shop/login/datasource/login_datasource.dart';
import 'package:new_shop/login/request/login_request.dart';
import 'package:new_shop/login/response/login_failed_response.dart';
import 'package:new_shop/login/response/login_success_response.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginDatasource _datasource;
  LoginBloc(this._datasource) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<UserTapLoginButtonEvent>((event, emit) async {
      emit(LoginLoading());
      final (LoginFailedResponse? failed, LoginSuccessResponse? success) =
          await _datasource.login(event.request);
      if (success != null) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailed());
      }
    });
  }
}
