// To parse this JSON data, do
//
//     final loginFailedResponse = loginFailedResponseFromJson(jsonString);

import 'dart:convert';

LoginFailedResponse loginFailedResponseFromJson(String str) =>
    LoginFailedResponse.fromJson(json.decode(str));

String loginFailedResponseToJson(LoginFailedResponse data) =>
    json.encode(data.toJson());

class LoginFailedResponse {
  String? message;
  int? statusCode;

  LoginFailedResponse({
    this.message,
    this.statusCode,
  });

  LoginFailedResponse copyWith({
    String? message,
    int? statusCode,
  }) =>
      LoginFailedResponse(
        message: message ?? this.message,
        statusCode: statusCode ?? this.statusCode,
      );

  factory LoginFailedResponse.fromJson(Map<String, dynamic> json) =>
      LoginFailedResponse(
        message: json["message"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "statusCode": statusCode,
      };
}
