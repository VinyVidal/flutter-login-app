import 'package:login/utils/datetime_helper.dart';

class UserModel {
  int? id;
  String name;
  String email;
  int createdAt;
  int updatedAt;
  String token;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json.containsKey('id') ? json['id'] : null,
        name = json['name'],
        email = json['email'],
        createdAt = DateTimeHelper.fromStringToTimestamp(json['created_at']),
        updatedAt = DateTimeHelper.fromStringToTimestamp(json['updated_at']),
        token = json.containsKey('token') ? json['token'] : '';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'token': token,
    };
  }
}
