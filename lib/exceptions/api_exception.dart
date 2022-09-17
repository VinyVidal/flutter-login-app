import 'package:login/services/api/api_response.dart';

class ApiException implements Exception {
  final int? statusCode;
  String message;
  final ApiResponse? response;

  ApiException({this.statusCode, this.message = '', this.response}) {
    if(message.isEmpty && response != null && response!.body.containsKey('message')) {
      message = response!.body['message'];
    }
  }
}