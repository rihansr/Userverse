import 'package:dio/dio.dart';
import '../../../../../../core/config/app_config.dart';
import '../../../../../../core/network/api_handler.dart';
import '../../../../../../core/network/server_env.dart';
import '../../../../../../core/utils/injections.dart';
import '../../../domain/models/user_model.dart';
import 'users_api.dart';

class UsersImplApi extends UsersApi {
  CancelToken cancelToken = CancelToken();

  UsersImplApi();

  @override
  Future<List<UserModel>> users() async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"]["content"],
      endpoint: serverEnv.users,
      method: Method.get,
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
    );
    return UserModel.fromJson(result.data ?? {});
  }
}
