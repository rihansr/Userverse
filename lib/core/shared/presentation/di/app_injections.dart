import '../../../network/api_handler.dart';
import '../../data/data_sources/local_storage.dart';
import '../../../utils/injections.dart';

initAppInjections() {
  sl.registerFactory<LocalStorage>(() => LocalStorage(sl()));
  sl.registerFactory<ApiHandler>(() => ApiHandler());
}