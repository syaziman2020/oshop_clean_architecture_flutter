import 'dart:convert';

import '../../../domain/entities/request/login_request.dart';

class LoginRequestModel extends LoginRequest {
  LoginRequestModel({required super.email, required super.password});

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
