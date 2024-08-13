// To parse this JSON data, do
//
//     final registerFailedResponse = registerFailedResponseFromJson(jsonString);

import 'dart:convert';

RegisterFailedResponse registerFailedResponseFromJson(String str) =>
    RegisterFailedResponse.fromJson(json.decode(str));

String registerFailedResponseToJson(RegisterFailedResponse data) =>
    json.encode(data.toJson());

class RegisterFailedResponse {
  List<String>? message;
  String? error;
  int? statusCode;

  RegisterFailedResponse({
    this.message,
    this.error,
    this.statusCode,
  });

  RegisterFailedResponse copyWith({
    List<String>? message,
    String? error,
    int? statusCode,
  }) =>
      RegisterFailedResponse(
        message: message ?? this.message,
        error: error ?? this.error,
        statusCode: statusCode ?? this.statusCode,
      );

  factory RegisterFailedResponse.fromJson(Map<String, dynamic> json) =>
      RegisterFailedResponse(
        message: json["message"] == null
            ? []
            : List<String>.from(json["message"]!.map((x) => x)),
        error: json["error"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "message":
            message == null ? [] : List<dynamic>.from(message!.map((x) => x)),
        "error": error,
        "statusCode": statusCode,
      };
}
