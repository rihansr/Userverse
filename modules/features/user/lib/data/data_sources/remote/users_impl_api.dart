import 'package:core/configs/configs.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/local/shared_prefs.dart';
import 'package:shared/data/data_sources/remote/network.dart';
import 'package:shared/di/service_locator.dart';
import '../../../domain/models/user_model.dart';
import 'users_api.dart';

@LazySingleton()
class UsersImplApi extends UsersApi {

  UsersImplApi();

  @override
  Future<List<UserModel>> users() async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"]["content"],
      endpoint: serverEnv.users,
      method: Method.get,
      token: sl<SharedPrefs>().token,
    );
    return UserModel.fromJsonList(result.data ?? []);
  }

  @override
  Future<UserModel> singleUser(int id) async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"]["content"],
      endpoint: serverEnv.users,
      pathParams: [id],
      method: Method.get,
      token: sl<SharedPrefs>().token,
    );
    return UserModel.fromJson(result.data ?? {});
  }
}
