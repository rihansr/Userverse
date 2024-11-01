import 'package:dio/dio.dart';
import '../../../../../core/config/app_config.dart';
import '../../../../../core/network/api_handler.dart';
import '../../../../../core/network/server_env.dart';
import '../../../../../core/shared/data/data_sources/shared_prefs.dart';
import '../../../../../core/utils/encryptor.dart';
import '../../../../../core/utils/injections.dart';
import 'auth_api.dart';

class AuthImplApi extends AuthApi {
  CancelToken cancelToken = CancelToken();

  AuthImplApi();

  @override
  Future<String?> login(Map<String, dynamic> body) async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"]["auth"],
      endpoint: serverEnv.login,
      method: Method.post,
      body: body,
    );
    String? token = result.data?["token"] as String?;
    if(token != null) sl<SharedPrefs>().token = encryptor(token);
    return token;
  }
}
