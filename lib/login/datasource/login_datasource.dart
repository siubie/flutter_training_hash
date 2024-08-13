import 'package:dartz/dartz.dart';
import 'package:new_shop/api_service.dart';
import 'package:new_shop/login/request/login_request.dart';
import 'package:new_shop/login/response/login_success_response.dart';

class LoginDatasource {
  Future<Either<String, LoginSuccessResponse>> login(
      LoginRequest request) async {
    try {
      final response = await APIService.instance.request(
        '/api/v1/auth/login/',
        DioMethod.post,
        param: request.toJson(),
        contentType: 'application/json',
      );

      if (response.statusCode == 200) {
        return Right(LoginSuccessResponse.fromJson(response.data));
      } else {
        return Left('Error');
      }
    } catch (e) {
      return Left('Error');
    }
  }
}
