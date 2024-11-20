class DioResponse {
  final int statusCode;
  final String? message;
  final dynamic data;

  DioResponse({this.statusCode = 404, this.message, this.data});

  DioResponse copyWith({
    int? statusCode,
    String? message,
    dynamic data,
  }) {
    return DioResponse(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  String toString() =>
      'Status Code: $statusCode\nMessage: $message\nData: $data';
}
