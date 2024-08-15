part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<ProductSuccessResponse> products;

  const ProductLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

final class ProductFailed extends ProductState {
  final String error;

  const ProductFailed({required this.error});

  @override
  List<Object> get props => [error];
}
