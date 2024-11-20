
import 'package:core/utils/debug.dart';
import 'package:dio/dio.dart';

class LoggerInterceptor extends Interceptor {
  LoggerInterceptor({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = false,
    this.responseHeader = true,
    this.responseBody = false,
    this.error = true,
  });

  /// Print request [Options]
  bool request;

  /// Print request header [Options.headers]
  bool requestHeader;

  /// Print request data [Options.balanceInfoModel]
  bool requestBody;

  /// Print [Response.data]
  bool responseBody;

  /// Print [Response.headers]
  bool responseHeader;

  /// Print error message
  bool error;

  @override
  Future onRequest(RequestOptions options, handler) async {
    debug.print(options.uri, tag: 'Request URI');

    if (request) {
      debug.print(
        'method: ${options.method}\n'
        'responseType: ${options.responseType.toString()}\n'
        'followRedirects: ${options.followRedirects}\n'
        'connectTimeout: ${options.connectTimeout?.inSeconds ?? 0}\n'
        'receiveTimeout: ${options.receiveTimeout?.inSeconds ?? 0}\n'
        'extra: ${options.extra}',
        tag: 'Data',
      );
    }
    if (requestHeader) {
      options.headers.forEach((key, v) => debug.print(v, tag: 'Headers: $key'));
    }
    if (requestBody) {
      debug.print(options.data, tag: 'Data');
    }
    return super.onRequest(options, handler);
  }

  @override
  Future onError(DioException err, handler) async {
    if (error) {
      debug.print(
        'uri: ${err.requestOptions.uri}\n'
        'Error: $err\nResponse ${err.response ?? ''}',
        tag: 'DioError',
      );
    }
    return super.onError(err, handler);
  }

  @override
  Future onResponse(Response response, handler) async {
    _printResponse(response);
    return super.onResponse(response, handler);
  }

  void _printResponse(Response response) {
    debug.print(response.requestOptions.uri, tag: 'uri');

    if (responseHeader) {
      debug.print(response.statusCode ?? 0, tag: 'statusCode');
      if (response.isRedirect == true) {
        debug.print(response.realUri.toString(), tag: 'redirect');
      }
      response.headers
          .forEach((key, v) => debug.print(v.join(','), tag: 'Headers: $key'));
    }
    if (responseBody) {
      debug.print(response.toString(), tag: 'Response');
    }
  }
}
