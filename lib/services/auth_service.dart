import 'package:login/exceptions/api_exception.dart';
import 'package:login/models/user_model.dart';
import 'package:login/services/api/api_response.dart';
import 'package:login/services/api/api_service.dart';
import 'package:login/services/secure_storage/secure_storage_item.dart';
import 'package:login/services/secure_storage/secure_storage_service.dart';
import 'package:login/services/user_service.dart';

class AuthService {
  final SecureStorageService _secureStorage = SecureStorageService.instance;
  final ApiService _apiService = ApiService.instance;
  final UserService _userService = UserService.instance;

  static AuthService instance = AuthService();
  UserModel? _user;

  Future<bool> isAuthenticated() async {
    String? token = await _secureStorage.readData('auth_token');

    if (token != null) {
      _apiService.setDefaultHeaders({'Authorization': 'Bearer $token'});
      return true;
    }

    _user = null;
    _apiService.setDefaultHeaders({});
    return false;
  }

  Future<void> login(String email, String password) async {
    ApiResponse loginResponse = await _apiService.post(
      'auth',
      body: {
        'email': email,
        'password': password,
      },
    );

    if (!loginResponse.success) {
      throw ApiException(
        statusCode: loginResponse.statusCode,
        response: loginResponse,
      );
    }

    if (!loginResponse.body.containsKey('data')) {
      throw Exception('Erro na resposta do servidor');
    }

    if (loginResponse.body['data']['token'] == null) {
      throw Exception('Erro na resposta do servidor');
    }

    String token = loginResponse.body['data']['token'];

    _apiService.setDefaultHeaders({'Authorization': 'Bearer $token'});
    await _secureStorage.writeData(StorageItem('auth_token', token));
  }

  Future<void> logout() async {
    await _secureStorage.deleteData('auth_token');
    await _apiService.delete('auth/token');
    _apiService.setDefaultHeaders({});
    _user = null;
  }

  Future<UserModel> user() async {
    if (_user != null) {
      return _user!;
    }

    _user = await _userService.getAuthenticatedUser();

    return _user!;
  }
}
