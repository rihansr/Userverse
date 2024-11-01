import '../../../network/api_handler.dart';
import '../../data/data_sources/shared_prefs.dart';
import '../../../utils/injections.dart';

initAppInjections() {
  sl.registerFactory<SharedPrefs>(() => SharedPrefs(sl()));
  sl.registerFactory<ApiHandler>(() => ApiHandler());
}
