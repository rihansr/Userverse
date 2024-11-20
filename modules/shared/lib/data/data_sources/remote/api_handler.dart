import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:core/utils/encryptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../di/service_locator.dart';
import '../../models/response_model.dart';
import 'error/dio_error_handler.dart';
import 'error/exceptions.dart';

enum Method { get, post, put, delete }

enum InvokeType { form, multipart, download }

@Singleton()
class ApiHandler {
  // static late Dio _dio;

  // static init() {
  //   _dio = Dio();
  //   _dio.interceptors.add(_loggerInterceptor);
  // }

  // static LoggerInterceptor get _loggerInterceptor => LoggerInterceptor(
  //       request: true,
  //       requestBody: true,
  //       error: true,
  //       responseBody: true,
  //       responseHeader: false,
  //       requestHeader: true,
  //     );

  Future<DioResponse> invoke({
    InvokeType via = InvokeType.form,
    required String baseUrl,
    String? endpoint,
    required Method method,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? additionalHeaders,
    var body,
    List<dynamic>? pathParams,
    Map<String, dynamic>? queryParams,
    Duration timeout = const Duration(seconds: 10),
    String? contentType,
    bool contentTypeSupported = false,
    String? token,
    bool enableEncoding = true,
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

    DioResponse response = await _exceptionHandler(
          (() async {
            BaseOptions baseOptions = BaseOptions(
              method: method.name,
              baseUrl: baseUrl,
              queryParameters: queryParams,
              headers: headers,
              contentType: contentTypeSupported
                  ? contentType ?? Headers.jsonContentType
                  : null,
              validateStatus: (status) => status! < 300,
            );

            int progress = -1;

            sl<Dio>().options = (() {
              switch (via) {
                case InvokeType.form:
                  return baseOptions.copyWith(
                    connectTimeout: timeout,
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
            }());

            return await sl<Dio>()
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
                .onError((error, stackTrace)  => throw 'Something went wrong!')
                .timeout(
                  timeout,
                  onTimeout: () => throw 'Request timed out',
                )
                .then(
                  (response) => DioResponse(
                    statusCode: response.statusCode ?? 404,
                    data: response.data,
                  ),
                );
          })(),
          showErrorMessage,
        ) ??
        DioResponse();

    return response;
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

  Future<dynamic>? _exceptionHandler(Future function,
      [showMessage = true]) async {
    try {
      return await function;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw CancelTokenException(handleDioError(e), e.response?.statusCode);
      } else {
        throw ServerException(handleDioError(e), e.response?.statusCode);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }
}
