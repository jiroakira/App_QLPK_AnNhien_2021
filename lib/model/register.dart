import 'dart:convert';

class RegisterRequestModel {
  String email;
  String password;

  RegisterRequestModel({
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

class RegisterResponseModel {
  final String token;
  final String error;

  RegisterResponseModel({this.token, this.error});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      token: json['token'],
      error: json['error'],
    );
  }
}
