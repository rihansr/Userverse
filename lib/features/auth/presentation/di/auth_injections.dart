import '../../../../core/utils/injections.dart';
import '../../data/data_sources/remote/auth_impl_api.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usacase.dart';

initAuthInjections() {
  sl.registerSingleton<AuthImplApi>(AuthImplApi());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));
  sl.registerSingleton<LoginUseCase>(LoginUseCase(sl()));
}