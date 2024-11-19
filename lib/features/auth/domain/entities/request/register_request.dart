class RegisterRequest {
  final String name;
  final String email;
  final String password;
  String? phone;
  String? roles;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    this.roles = "USER",
    required this.phone,
  });
}
