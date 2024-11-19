import 'dart:convert';

import '../../../domain/entities/request/register_request.dart';

class RegisterRequestModel extends RegisterRequest {
  RegisterRequestModel({
    required super.email,
    required super.password,
    required super.name,
    super.phone,
    super.roles,
  });

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'roles': roles,
        'phone': phone,
      };
}
