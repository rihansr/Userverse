import '../../../../core/utils/injections.dart';
import '../../data/data_sources/remote/users_impl_api.dart';
import '../../data/repositories/users_repository_impl.dart';
import '../../domain/repositories/users_repository.dart';
import '../../domain/usecases/single_user_usecase.dart';
import '../../../dashboard/domain/usecases/users_usecase.dart';

initUserInjections() {
  sl.registerSingleton<UsersImplApi>(UsersImplApi());
  sl.registerSingleton<UsersRepository>(UsersRepositoryImpl(sl()));
  sl.registerSingleton<UsersUseCase>(UsersUseCase(sl()));
  sl.registerSingleton<SingleUserUseCase>(SingleUserUseCase(sl()));
}
