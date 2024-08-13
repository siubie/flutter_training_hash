// To parse this JSON data, do
//
//     final loginSuccessResponse = loginSuccessResponseFromJson(jsonString);

import 'dart:convert';

LoginSuccessResponse loginSuccessResponseFromJson(String str) =>
    LoginSuccessResponse.fromJson(json.decode(str));

String loginSuccessResponseToJson(LoginSuccessResponse data) =>
    json.encode(data.toJson());

class LoginSuccessResponse {
  String? accessToken;
  String? refreshToken;

  LoginSuccessResponse({
    this.accessToken,
    this.refreshToken,
  });

  LoginSuccessResponse copyWith({
    String? accessToken,
    String? refreshToken,
  }) =>
      LoginSuccessResponse(
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
      );

  factory LoginSuccessResponse.fromJson(Map<String, dynamic> json) =>
      LoginSuccessResponse(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
      };
}
