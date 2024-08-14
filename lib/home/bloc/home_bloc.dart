import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_shop/shared/datasource/token_datasource.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TokenDatasource _tokenDatasource;
  HomeBloc(this._tokenDatasource) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<UserTapLogoutButton>((event, emit) {
      emit(HomeLoading());
      _tokenDatasource.removeToken();
      emit(HomeLogoutSuccess());
    });
  }
}
