import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_shop/product/datasource/product_datasource.dart';
import 'package:new_shop/product/response/product_success_response.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductDatasource _productDatasource;
  ProductBloc(this._productDatasource) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SystemLoadProductEvent>((event, emit) async {
      emit(ProductLoading());
      final (error, success) = await _productDatasource.getProduct();
      if (success != null) {
        emit(
          ProductLoaded(products: success),
        );
      } else {
        emit(
          ProductFailed(error: error!),
        );
      }
    });
  }
}
