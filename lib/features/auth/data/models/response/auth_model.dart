import 'dart:convert';

import '../../../domain/entities/response/auth_response.dart';

class AuthModel extends AuthResponse {
  final String accessToken;
  final UserModel user;
  AuthModel({
    required this.accessToken,
    required this.user,
  }) : super(token: accessToken, user: user);

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        accessToken: json["access_token"],
        user: UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "user": user.toJson(),
      };
}

class UserModel extends User {
  final dynamic emailVerifiedAt;
  final dynamic twoFactorSecret;
  final dynamic twoFactorRecoveryCodes;
  final dynamic twoFactorConfirmedAt;

  UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.fcmId,
    super.phone,
    required super.roles,
    this.emailVerifiedAt,
    this.twoFactorSecret,
    this.twoFactorRecoveryCodes,
    this.twoFactorConfirmedAt,
    required super.createdAt,
    super.updatedAt,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        fcmId: json["fcm_id"],
        phone: json["phone"],
        roles: json["roles"],
        emailVerifiedAt: json["email_verified_at"],
        twoFactorSecret: json["two_factor_secret"],
        twoFactorRecoveryCodes: json["two_factor_recovery_codes"],
        twoFactorConfirmedAt: json["two_factor_confirmed_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "fcm_id": fcmId,
        "phone": phone,
        "roles": roles,
        "email_verified_at": emailVerifiedAt,
        "two_factor_secret": twoFactorSecret,
        "two_factor_recovery_codes": twoFactorRecoveryCodes,
        "two_factor_confirmed_at": twoFactorConfirmedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
