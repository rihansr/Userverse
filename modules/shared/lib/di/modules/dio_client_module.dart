import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../data/data_sources/remote/logger_interceptor.dart';

@module
abstract class DioClientModule {
  @singleton
  @FactoryMethod(preResolve: true)
  Dio dio() {
    final dio = Dio();

    dio.interceptors.add(LoggerInterceptor(
      request: true,
      requestBody: true,
      error: true,
      responseBody: true,
      responseHeader: false,
      requestHeader: true,
    ));

    return dio;
  }
}