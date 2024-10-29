import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../utils/debug.dart';
import '../utils/encryptor.dart';
import '../shared/enums.dart';
import '../shared/strings.dart';
import '../shared/styles.dart';
import 'navigation_service.dart';

final api = _Api.function;

enum Method { get, post, put, delete }

enum InvokeType { regular, multipart, download }

class _Api {
  static _Api get function => _Api._();
  _Api._();

  Future<Response> invoke({
    InvokeType via = InvokeType.regular,
    required String baseUrl,
    String? endpoint,
    required Method method,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? additionalHeaders,
    var body,
    List<dynamic>? pathParams,
    Map<String, dynamic>? queryParams,
    Duration timeout = const Duration(seconds: 30),
    String? contentType,
    bool contentTypeSupported = false,
    String? token,
    bool enableEncoding = true,
    bool justifyResponse = true,
    bool showErrorMessage = true,
    Encoding? encoding,
    Function(int)? onProgress,
  }) async {
    endpoint = _buildEndpoint(
      baseUrl: baseUrl,
      endpoint: endpoint ?? '',
      pathParams: pathParams ?? [],
    );

    headers ??= _buildHeaders(
      token: token,
    )..addAll(additionalHeaders ?? {});

    body = enableEncoding && via != InvokeType.multipart
        ? body == null
            ? null
            : jsonEncode(body)
        : body;

    encoding ??= enableEncoding ? utf8 : null;

    Response response = await _exceptionHandler(
          (() async {
            BaseOptions baseOptions = BaseOptions(
              method: method.name,
              connectTimeout: timeout,
              sendTimeout: timeout,
              receiveTimeout: timeout,
              baseUrl: baseUrl,
              queryParameters: queryParams,
              headers: headers,
              contentType: contentTypeSupported
                  ? contentType ?? Headers.jsonContentType
                  : null,
              validateStatus: (status) => true,
            );

            final LogInterceptor logInterceptor = LogInterceptor(
              request: false,
              requestHeader: false,
              responseHeader: false,
              error: false,
              logPrint: (s) => {},
            );

            int progress = -1;

            Dio dioClient = Dio(
              (() {
                switch (via) {
                  case InvokeType.regular:
                    return baseOptions.copyWith(
                      sendTimeout: timeout,
                      receiveTimeout: timeout,
                    );
                  case InvokeType.download:
                    return baseOptions.copyWith(
                      responseType: ResponseType.bytes,
                      followRedirects: false,
                    );
                  default:
                    return baseOptions;
                }
              }()),
            )..interceptors.addAll([
                logInterceptor,
              ]);

            return await dioClient
                .request(
                  endpoint!,
                  data: via == InvokeType.multipart
                      ? FormData.fromMap(body as Map<String, dynamic>)
                      : body,
                  onSendProgress: (received, total) {
                    int newPercentage =
                        total != -1 ? (received / total * 100).toInt() : 0;
                    if (progress != newPercentage) {
                      progress = newPercentage;
                      onProgress?.call(progress);
                    }
                  },
                  onReceiveProgress: (received, total) {
                    int newPercentage =
                        total != -1 ? (received / total * 100).toInt() : 0;
                    if (progress != newPercentage) {
                      progress = newPercentage;
                      onProgress?.call(progress);
                    }
                  },
                )
                .onError((error, stackTrace) => throw (error.toString()))
                .timeout(
                  timeout,
                  onTimeout: () => throw TimeoutException(null),
                )
                .then(
                  (response) => Response(
                    statusCode: response.statusCode ?? 404,
                    data: response.data,
                  ),
                );
          })(),
          showErrorMessage,
        ) ??
        Response();

    return justifyResponse
        ? _justifyResponse(response,
            tag: endpoint, showMessage: showErrorMessage)
        : response;
  }

  String _buildEndpoint({
    required String baseUrl,
    String endpoint = '',
    List<dynamic> pathParams = const [],
  }) =>
      '$baseUrl${endpoint.isEmpty ? '' : '/$endpoint'}${pathParams.isNotEmpty ? '/${pathParams.join('/')}' : ''}';

  Map<String, dynamic> _buildHeaders({String? token}) => {
        HttpHeaders.acceptHeader: 'application/json',
        if (token != null)
          HttpHeaders.authorizationHeader: "Bearer ${decryptor(token)}",
      };

  String basicAuthGenerator(
          {required String username, required String password}) =>
      'Basic ${base64Encode(utf8.encode('$username:$password'))}';

  Future<dynamic>? _exceptionHandler(Future function,
      [showMessage = true]) async {
    try {
      return await function;
    } on SocketException {
      _showErrorMessage(
        string.of().networkNotAvailable,
        type: AlertType.error,
        logOnly: !showMessage,
        tag: "Socket Exception",
      );
    } on TimeoutException {
      _showErrorMessage(
        string.of().requestTimeout,
        type: AlertType.error,
        logOnly: !showMessage,
        tag: "Timeout Exception",
      );
    } catch (e) {
      _showErrorMessage(
        e.toString(),
        type: AlertType.error,
        logOnly: !showMessage,
        tag: "Exception",
      );
    }
    return null;
  }

  Response _justifyResponse(
    Response response, {
    String tag = "API",
    bool showMessage = true,
  }) {
    if ((response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202 ||
        response.statusCode == 409)) {
      debug.print(response.data, tag: tag);
      return response.copyWith(
        message: (response.data is Map?) ? (response.data?['message']) : null,
      );
    } else {
      _showErrorMessage(response,
          tag: tag, logOnly: !showMessage, type: AlertType.error);
    }
    return response.copyWith(data: null);
  }

  void _showErrorMessage(
    Object? response, {
    String? tag,
    String? orElse,
    String? actionLabel,
    dynamic Function()? onAction,
    AlertType? type,
    bool logOnly = false,
  }) {
    if (response == null) return;
    response = (response is Response
            ? response.data is Map
                ? response.data.containsKey('error')
                    ? response.data['error'] is Map
                        ? response.data['error']['message']
                        : response.data['error']
                    : response.data.containsKey('message')
                        ? response.data['message']
                        : response.data.containsKey('errors')
                            ? response.data['errors'].toString()
                            : orElse ?? string.of().someErrorOccured
                : response.data.toString().isNotEmpty
                    ? response.data
                    : string.of().noDataFound
            : response) ??
        orElse ??
        string.of().someErrorOccured;

    response = '${response ?? ''}';
    debug.print(response, tag: tag ?? "Error Log");

    if (logOnly) {
      return;
    } else if ('$response'.isNotEmpty) {
      ScaffoldMessenger.of(navigator.context).showSnackBar(
        style.snackbar(
          '$response',
          type: type,
          onAction: onAction,
          actionLabel: actionLabel,
        ),
      );
    }
  }
}

class Response {
  final int statusCode;
  final String? message;
  final dynamic data;

  Response({this.statusCode = 404, this.message, this.data});

  Response copyWith({
    int? statusCode,
    String? message,
    dynamic data,
  }) {
    return Response(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  String toString() =>
      'Status Code: $statusCode\nMessage: $message\nData: $data';
}
