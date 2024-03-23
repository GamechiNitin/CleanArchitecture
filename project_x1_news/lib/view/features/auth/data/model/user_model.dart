import 'package:project_x1_news/core/enities/user.dart';

class UserModel extends User {
  UserModel({
    required super.name,
    required super.email,
    required super.password,
    required super.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      password: data['password'],
    );
  }
}
