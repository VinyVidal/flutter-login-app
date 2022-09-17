class ApiResponse {
  final int statusCode;
  final Map<String, dynamic> body;
  final bool success;

  const ApiResponse(this.statusCode, this.body): success = (statusCode >= 200 && statusCode <= 299);
}