import 'package:project_x1_news/view/features/auth/domain/enities/user.dart';

class UserModel extends User {
  UserModel({
    required super.name,
    required super.email,
    required super.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'],
      email: data['email'],
      password: data['password'],
    );
  }
}
