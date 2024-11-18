class AuthResponse {
  final String token;
  final User user;
  AuthResponse({required this.token, required this.user});
}

class User {
  final int id;
  final String name;
  final String email;
  String? fcmId;
  String? phone;
  final String roles;
  final DateTime createdAt;
  DateTime? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.roles,
    required this.createdAt,
    this.fcmId,
    this.phone,
    this.updatedAt,
  });
}

class MessageValidate {
  final String message;
  MessageValidate({required this.message});
}
