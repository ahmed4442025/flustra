class LoginRequest {
  final String companyEmail;
  final String username;
  final String password;

  LoginRequest({required this.companyEmail, required this.username, required this.password});

  Map<String, dynamic> toJson() => {'company_email': companyEmail, 'username': username, 'password': password};
}
