import 'package:dartz/dartz.dart';
import 'package:new_shop/api_service.dart';
import 'package:new_shop/register/request/register_request.dart';
import 'package:new_shop/register/response/register_response.dart';

class RegisterDatasource {
  Future<Either<String, RegisterResponse>> registerUser(
      RegisterRequest request) async {
    final response = await APIService.instance.request(
      '/api/v1/users/',
      DioMethod.post,
      param: request.toJson(),
      contentType: 'application/json',
    );
    if (response.statusCode == 201) {
      return Right(RegisterResponse.fromJson(response.data));
    } else {
      return Left('Error');
    }
  }
}
