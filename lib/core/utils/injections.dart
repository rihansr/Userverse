import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/presentation/di/auth_injections.dart';
import '../../features/user/presentation/di/user_injections.dart';
import '../network/api_handler.dart';
import '../shared/presentation/di/app_injections.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  await registerSharedPreferences();
  await ApiHandler.init();
  await initAppInjections();
  await initAuthInjections();
  await initUserInjections();
}

registerSharedPreferences() async {
  sl.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });
  await sl.isReady<SharedPreferences>();
}
