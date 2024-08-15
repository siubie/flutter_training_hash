import 'package:dio/dio.dart';
import 'package:new_shop/api_service.dart';
import 'package:new_shop/product/response/product_success_response.dart';

class ProductDatasource {
  Future<(String?, List<ProductSuccessResponse>?)> getProduct() async {
    try {
      final response = await APIService.instance.request(
        '/api/v1/products/?offset=0&limit=10',
        DioMethod.get,
        contentType: 'application/json',
      );

      return (
        null,
        List<ProductSuccessResponse>.from(
          response.data.map(
            (x) => ProductSuccessResponse.fromJson(x),
          ),
        )
      );
    } on DioException catch (e) {
      return (
        "Failed to get product $e.message",
        null,
      );
    }
  }
}
