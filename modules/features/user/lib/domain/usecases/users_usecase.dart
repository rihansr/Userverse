import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/user_model.dart';
import '../repositories/users_repository.dart';

@LazySingleton()
class UsersUseCase {
  final UsersRepository repository;

  UsersUseCase(this.repository);

  Future<Either<Failure, List<UserModel>>> invoke() async {
    final result = await repository.users();
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
