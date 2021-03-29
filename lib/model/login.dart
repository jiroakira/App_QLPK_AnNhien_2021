import 'dart:convert';

class LoginResponseModel {
  final String token;

  LoginResponseModel({
    this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(token: json['token']);
  }
}

class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({
    this.email,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email.trim(),
      'password': password.trim(),
    };
  }

  String toJson() => json.encode(toMap());
}
