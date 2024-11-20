import 'package:core/configs/app_config.dart';
import 'package:core/utils/encryptor.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/local/shared_prefs.dart';
import 'package:shared/data/data_sources/remote/network.dart';
import 'package:shared/di/service_locator.dart';
import 'auth_api.dart';

@LazySingleton()
class AuthImplApi extends AuthApi {

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
