import 'package:dio/dio.dart';
import 'package:new_shop/api_service.dart';
import 'package:new_shop/register/request/register_request.dart';
import 'package:new_shop/register/response/register_failed_response.dart';
import 'package:new_shop/register/response/register_response.dart';

class RegisterDatasource {
  Future<Object> registerUser(RegisterRequest request) async {
    try {
      final response = await APIService.instance.request(
        '/api/v1/users/',
        DioMethod.post,
        param: request.toJson(),
        contentType: 'application/json',
      );
      return RegisterResponse.fromJson(response.data);
    } on DioException catch (e) {
      return RegisterFailedResponse.fromJson(e.response!.data);
    }
  }
}
