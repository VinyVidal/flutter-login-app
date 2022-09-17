import 'dart:developer';

import 'package:login/exceptions/api_exception.dart';
import 'package:login/models/user_model.dart';
import 'package:login/services/api/api_response.dart';
import 'package:login/services/api/api_service.dart';

class UserService {
  static final UserService instance = UserService();

  final ApiService _apiService = ApiService.instance;

  Future<UserModel> getAuthenticatedUser() async {
    ApiResponse response = await _apiService.get('auth/me');

    if(!response.success) {
      throw ApiException(statusCode: response.statusCode, response: response);
    }

    return UserModel.fromJson(response.body['data']);
  }

  Future<UserModel> createUser({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    ApiResponse response = await _apiService.post('user', body: {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });

    if(!response.success) {
      throw ApiException(statusCode: response.statusCode, response: response);
    }

    return UserModel.fromJson(response.body['data']);
  }
}