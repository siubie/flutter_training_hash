import 'package:dio/dio.dart';
import 'package:new_shop/api_service.dart';
import 'package:new_shop/login/request/login_request.dart';
import 'package:new_shop/login/response/login_failed_response.dart';
import 'package:new_shop/login/response/login_success_response.dart';

class LoginDatasource {
  Future<(LoginFailedResponse?, LoginSuccessResponse?)> login(
      LoginRequest request) async {
    try {
      final response = await APIService.instance.request(
        '/api/v1/auth/login/',
        DioMethod.post,
        param: request.toJson(),
        contentType: 'application/json',
      );

      return (
        null,
        LoginSuccessResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      return (
        LoginFailedResponse.fromJson(e.response!.data),
        null,
      );
    }
  }
}
