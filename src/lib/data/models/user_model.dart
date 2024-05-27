// lib/data/models/user_model.dart

class UserModel {
  final String email;
  final String token;

  UserModel({required this.email, required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json['email'],
    token: json['token'],
  );
}

