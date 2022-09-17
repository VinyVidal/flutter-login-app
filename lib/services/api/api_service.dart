import 'dart:convert';
import 'package:http/http.dart';
import 'package:login/exceptions/api_exception.dart';
import 'package:login/services/api/api_response.dart';

class ApiService {
  final String _authority = '10.0.2.2:8000';
  final String _partialPath = '/api';
  final Client _client = Client();
  final Map<String, String> _requestHeaders = {
    'X-Locale': 'pt-BR',
  };

  static final ApiService instance = ApiService();

  Future<ApiResponse> get(String path, {Map<String, String>? headers}) async {
    if (headers != null) {
      _requestHeaders.addAll(headers);
    }

    Response response = await _client.get(
      Uri.http(_authority, '$_partialPath/$path'),
      headers: _requestHeaders,
    );

    return _handleResponse(response);
  }

  Future<ApiResponse> post(String path, {Object? body, Map<String, String>? headers}) async {
    if (headers != null) {
      _requestHeaders.addAll(headers);
    }

    Response response = await _client.post(
      Uri.http(_authority, '$_partialPath/$path'),
      body: body,
      headers: _requestHeaders,
    );

    return _handleResponse(response);
  }

  Future<ApiResponse> delete(String path, {Map<String, String>? headers}) async {
    if (headers != null) {
      _requestHeaders.addAll(headers);
    }

    Response response = await _client.delete(
      Uri.http(_authority, '$_partialPath/$path'),
      headers: _requestHeaders,
    );

    return _handleResponse(response);
  }

  ApiResponse _handleResponse(Response response) {
    int statusCode = response.statusCode;

    Map<String, dynamic> decodedResponse = {};

    if (response.body.isNotEmpty) {
      decodedResponse = jsonDecode(response.body);
    }

    ApiResponse apiResponse = ApiResponse(statusCode, decodedResponse);

    if (!apiResponse.success) {
      throw ApiException(statusCode: statusCode, response: apiResponse);
    }

    return apiResponse;
  }

  void setDefaultHeaders(Map<String, String> newHeaders) {
    _requestHeaders.addAll(newHeaders);
  }
}
