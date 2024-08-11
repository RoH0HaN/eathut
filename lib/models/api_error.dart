import 'dart:convert';

ApiError apiErrorFromJson(String str) => ApiError.fromJson(json.decode(str));

String apiErrorToJson(ApiError data) => json.encode(data.toJson());

class ApiError {
  int statusCode;
  dynamic data;
  String message;
  bool success;

  ApiError({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) => ApiError(
        statusCode: json["statusCode"],
        data: json["data"],
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": data,
        "message": message,
        "success": success,
      };
}
