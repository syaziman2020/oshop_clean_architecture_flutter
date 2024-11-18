import 'dart:convert';

import '../../../domain/entities/response/auth_response.dart';

class MessageValidateModel extends MessageValidate {
  MessageValidateModel({
    required super.message,
  });

  factory MessageValidateModel.fromRawJson(String str) =>
      MessageValidateModel.fromJson(json.decode(str));

  factory MessageValidateModel.fromJson(Map<String, dynamic> json) =>
      MessageValidateModel(
        message: json["message"],
      );
}