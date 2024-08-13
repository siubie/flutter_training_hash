import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_shop/login/datasource/login_datasource.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginDatasource _datasource;
  LoginBloc(this._datasource) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
  }
}
