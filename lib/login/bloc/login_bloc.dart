import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_shop/login/datasource/login_datasource.dart';
import 'package:new_shop/login/request/login_request.dart';
import 'package:new_shop/login/response/login_failed_response.dart';
import 'package:new_shop/login/response/login_success_response.dart';
import 'package:new_shop/shared/datasource/token_datasource.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginDatasource _datasource;
  final TokenDatasource _tokenDatasource;
  LoginBloc(this._datasource, this._tokenDatasource) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});

    on<UserTapLoginButtonEvent>((event, emit) async {
      emit(LoginLoading());
      final (LoginFailedResponse? failed, LoginSuccessResponse? success) =
          await _datasource.login(event.request);
      if (success != null) {
        //save token to shared preferences
        await _tokenDatasource.saveToken(success.accessToken!);
        emit(LoginSuccess());
      } else {
        emit(
          LoginFailed(
              message: "Login failed, please check your email/password"),
        );
      }
    });

    on<SystemCheckTokenEvent>((event, emit) async {
      final token = await _tokenDatasource.getToken();
      if (token != null) {
        emit(LoginSuccess());
      } else {
        emit(LoginInitial());
      }
    });
  }
}
