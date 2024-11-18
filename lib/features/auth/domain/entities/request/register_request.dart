class RegisterRequest {
  final String name;
  final String email;
  final String password;
  String? phone;
  final String roles;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.roles,
    this.phone,
  });
}
