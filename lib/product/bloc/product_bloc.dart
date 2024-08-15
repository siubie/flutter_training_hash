import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_shop/product/response/product_success_response.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SystemLoadProductEvent>((event, emit) async {
      emit(ProductLoading());
      await Future.delayed(const Duration(seconds: 2));
      emit(const ProductLoaded(products: []));
    });
  }
}
